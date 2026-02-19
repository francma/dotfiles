#!/usr/bin/tcc -run

#include <stdio.h>
#include <sys/timerfd.h>
#include <unistd.h>
#include <stdint.h>
#include <time.h>

int main() {
    struct timespec now;

    int tfd = timerfd_create(CLOCK_REALTIME, 0);
    clock_gettime(CLOCK_REALTIME, &now);

    time_t next_minute = now.tv_sec - (now.tv_sec % 60) + 60;

    struct itimerspec timer = {
        .it_value = { .tv_sec = next_minute, .tv_nsec = 0 },
        .it_interval = { .tv_sec = 60, .tv_nsec = 0 }
    };

    timerfd_settime(tfd, TFD_TIMER_ABSTIME, &timer, NULL);

    uint64_t expirations;
    char buffer[sizeof("23:59")];
    do {
        clock_gettime(CLOCK_REALTIME, &now);
        now.tv_sec += 1;

        struct tm *time_info = localtime(&now.tv_sec);
        strftime(buffer, sizeof(buffer), "%H:%M", time_info);
        puts(buffer);
        fflush(stdout);
    } 
    while (read(tfd, &expirations, sizeof(expirations)) == sizeof(expirations));

    return 0;
}

