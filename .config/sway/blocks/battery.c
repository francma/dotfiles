#!/usr/bin/tcc -run

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <linux/netlink.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/timerfd.h>
#include <poll.h>
#include <stdint.h>
#include <stdbool.h>

#define UEVENT_BUFFER_SIZE 2048

enum power_state {
    NOT_CHARGING = 1,
    FULL = 2,
    UNKNOWN = 3,
    DISCHARGING = 4,
    CHARGING = 5,
};

enum power_state power_state_from_string(const char *str) {
    if (strcmp("Not charging", str) == 0) {
        return NOT_CHARGING;
    }
    else if(strcmp("Full", str) == 0) {
        return FULL;
    }
    else if(strcmp("Discharging", str) == 0) {
        return DISCHARGING;
    }
    else if(strcmp("Charging", str) == 0) {
        return CHARGING;
    }

    return UNKNOWN;
}

int main() {
    struct sockaddr_nl nls;
    char buffer[UEVENT_BUFFER_SIZE * 2];
    
    memset(&nls, 0, sizeof(nls));
    nls.nl_family = AF_NETLINK;
    nls.nl_pid = getpid();
    nls.nl_groups = 1;
    
    // SOCK_DGRAM = get 1 message at the time
    int sock = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_KOBJECT_UEVENT);
    if (sock < 0) {
        perror("socket failed");
        return 1;
    }
    
    if (bind(sock, (struct sockaddr*)&nls, sizeof(nls)) < 0) {
        perror("bind failed");
        return 1;
    }

    int timerfd = timerfd_create(CLOCK_REALTIME, TFD_CLOEXEC);
    if (timerfd < 0) {
        perror("timerfd_create");
        return 1;
    }

    struct itimerspec timer = {
        .it_value = { .tv_sec = 60, .tv_nsec = 0 },
        .it_interval = { .tv_sec = 60, .tv_nsec = 0 }
    };

    timerfd_settime(timerfd, 0, &timer, NULL);

    struct pollfd pfds[] = {
        { .fd = sock, .events = POLLIN },
        { .fd = timerfd, .events = POLLIN },
    };

    int capacity_fd = open("/sys/class/power_supply/BAT0/capacity", O_RDONLY);
    int status_fd = open("/sys/class/power_supply/BAT0/status", O_RDONLY);
    
    bool update = true;
    enum power_state previous_state = UNKNOWN;
    char capacity_buf[255];
    char status_buf[255];
    while (1) {
        if (update) {
            read(capacity_fd, capacity_buf, sizeof(capacity_buf) - 1);
            read(status_fd, status_buf, sizeof(status_buf) - 1);

            char *pos;
            if ((pos = strchr(capacity_buf, '\n')) == NULL) {
                printf("ERR");
                return 1;
            }
            *pos = '\0';

            if ((pos = strchr(status_buf, '\n')) == NULL) {
                printf("ERR");
                return 1;
            }
            *pos = '\0';

            enum power_state state = power_state_from_string(status_buf);
            switch (state) {
                case NOT_CHARGING:
                case FULL:
                case UNKNOWN:
                    if (previous_state != state) {
                        printf("\n");
                        fflush(stdout);
                    }
                    break;
                case DISCHARGING:
                    printf("BAT -%s\n", capacity_buf);
                    fflush(stdout);
                    break;
                case CHARGING:
                    printf("BAT +%s\n", capacity_buf);
                    fflush(stdout);
                    break;
            }

            lseek(capacity_fd, 0, SEEK_SET);
            lseek(status_fd, 0, SEEK_SET);

            previous_state = state;
            update = false;
        }

        if (poll(pfds, 2, -1) < 0) {
            if (errno == EINTR) continue;
            perror("poll");
            return 1;
        }

        if (pfds[1].revents & POLLIN) {
            uint64_t expirations;
            read(timerfd, &expirations, sizeof(expirations));

            update = true;
            continue;
        }
        
        if (pfds[0].revents & POLLIN) {
            ssize_t len = recv(sock, buffer, sizeof(buffer), 0);
            
            if (len < 0) {
                if (errno == EINTR) continue;
                perror("recv");
                break;
            }
            
            if (len == 0) {
                continue;
            }

            // first line looks something like this:
            // change@/devices/pci0000:00/0000:00:14.3/PNP0C09:00/ACPI0003:00/power_supply/AC
            // all lines are \0 separated
            if (strstr(buffer, "/power_supply/")) {
                update = true;

                /* char *pos = buffer;
                char *end = buffer + len;
                while (pos < end) {
                    size_t str_len = strlen(pos);
                    printf("%s\n", pos);
                    pos += str_len + 1;
                }
                printf("---\n"); */
            }
        }
    }
    
    close(sock);
    return 0;
}
