//
//  TraceRoute.m
//  LDNetCheckServiceDemo
//
//  Created by 庞辉 on 14-10-29.
//  Copyright (c) 2014年 庞辉. All rights reserved.
//

#include <netdb.h>
#include <arpa/inet.h>
#include <sys/time.h>

#import "LDNetTraceRoute.h"
#import "LDNetTimer.h"

@implementation LDNetTraceRoute

/**
 * 初始化
 */
- (LDNetTraceRoute *)initWithMaxTTL:(int)ttl
                            timeout:(int)timeout
                        maxAttempts:(int)attempts
                               port:(int)port
{
    self = [super init];
    if (self) {
        maxTTL = ttl;
        udpPort = port;
        readTimeout = timeout;
        maxAttempts = attempts;
    }

    return self;
}


/**
 * 监控tranceroute 路径
 */
- (Boolean)doTraceRoute:(NSString *)host
{
    //从name server获取server主机的地址
    struct hostent *host_entry = gethostbyname(host.UTF8String);
    if (host_entry == NULL) {
        if (_delegate != nil) {
            [_delegate appendRouteLog:@"TraceRoute>>> Could not get host address"];
            [_delegate traceRouteDidEnd];
        }
        return false;
    }
    char *ip_addr;
    ip_addr = inet_ntoa(*((struct in_addr *)host_entry->h_addr_list[0]));


    //初始化套接口
    struct sockaddr_in destination, fromAddr;
    int recv_sock;
    int send_sock;
    Boolean error = false;

    isrunning = true;
    //创建一个支持ICMP协议的UDP网络套接口（用于接收）
    if ((recv_sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_ICMP)) < 0) {
        if (_delegate != nil) {
            [_delegate appendRouteLog:@"TraceRoute>>> Could not create recv socket"];
            [_delegate traceRouteDidEnd];
        }
        return false;
    }

    //创建一个UDP套接口（用于发送）
    if ((send_sock = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        if (_delegate != nil) {
            [_delegate appendRouteLog:@"TraceRoute>>> Could not create xmit socket"];
            [_delegate traceRouteDidEnd];
        }
        return false;
    }

    //设置server主机的套接口地址
    memset(&destination, 0, sizeof(destination));
    destination.sin_family = AF_INET;
    destination.sin_addr.s_addr = inet_addr(ip_addr);
    destination.sin_port = htons(udpPort);

    char *cmsg = "GET / HTTP/1.1\r\n\r\n";
    socklen_t n = sizeof(fromAddr);
    char buf[100];

    int ttl = 1;  // index sur le TTL en cours de traitement.
    int timeoutTTL = 0;
    bool icmp = false;  // Positionné à true lorsqu'on reçoit la trame ICMP en retour.
    long startTime;     // Timestamp lors de l'émission du GET HTTP
    long delta;         // Durée de l'aller-retour jusqu'au hop.

    // On progresse jusqu'à un nombre de TTLs max.
    while (ttl <= maxTTL) {
        memset(&fromAddr, 0, sizeof(fromAddr));
        //设置sender 套接字的ttl
        if (setsockopt(send_sock, IPPROTO_IP, IP_TTL, &ttl, sizeof(ttl)) < 0) {
            error = true;
            if (_delegate != nil) {
                [_delegate appendRouteLog:@"TraceRoute>>> setsockopt failled"];
            }
        }


        //每一步连续发送maxAttenpts报文
        icmp = false;
        NSMutableString *traceTTLLog = [[NSMutableString alloc] initWithCapacity:20];
        [traceTTLLog appendFormat:@"%d\t", ttl];
        for (int try = 0; try < maxAttempts; try ++) {
            startTime = [LDNetTimer getMicroSeconds];
            //发送成功返回值等于发送消息的长度
            if (sendto(send_sock, cmsg, sizeof(cmsg), 0, (struct sockaddr *)&destination,
                       sizeof(destination)) != sizeof(cmsg)) {
                error = true;
                [traceTTLLog appendFormat:@"*\t"];
            }

            long res = 0;
            //从（已连接）套接口上接收数据，并捕获数据发送源的地址。
            if (-1 == fcntl(recv_sock, F_SETFL, O_NONBLOCK)) {
                printf("fcntl socket error!\n");
                return -1;
            }
            /* set recvfrom from server timeout */
            struct timeval tv;
            fd_set readfds;
            tv.tv_sec = 1;
            tv.tv_usec = 0;  //设置了1s的延迟
            FD_ZERO(&readfds);
            FD_SET(recv_sock, &readfds);
            select(recv_sock + 1, &readfds, NULL, NULL, &tv);
            if (FD_ISSET(recv_sock, &readfds) > 0) {
                timeoutTTL = 0;
                if ((res = recvfrom(recv_sock, buf, 100, 0, (struct sockaddr *)&fromAddr, &n)) <
                    0) {
                    error = true;
                    [traceTTLLog appendFormat:@"%s\t", strerror(errno)];
                } else {
                    icmp = true;
                    delta = [LDNetTimer computeDurationSince:startTime];

                    //将“二进制整数” －> “点分十进制，获取hostAddress和hostName
                    char display[16] = {0};
                    inet_ntop(AF_INET, &fromAddr.sin_addr.s_addr, display, sizeof(display));
                    NSString *hostAddress = [NSString stringWithFormat:@"%s", display];
                    if (try == 0) {
                        [traceTTLLog appendFormat:@"%@\t\t", hostAddress];
                    }
                    [traceTTLLog appendFormat:@"%0.2fms\t", (float)delta / 1000];
                }
            } else {
                timeoutTTL++;
                break;
            }

            // On teste si l'utilisateur a demandé l'arrêt du traceroute
            @synchronized(running)
            {
                if (!isrunning) {
                    ttl = maxTTL;
                    // On force le statut d'icmp pour ne pas générer un Hop en sortie de boucle;
                    icmp = true;
                    break;
                }
            }
        }

        //输出报文,如果三次都无法监控接收到报文，跳转结束
        if (icmp) {
            [self.delegate appendRouteLog:traceTTLLog];
        } else {
            //如果连续三次接收不到icmp回显报文
            if (timeoutTTL >= 4) {
                break;
            } else {
                [self.delegate appendRouteLog:[NSString stringWithFormat:@"%d\t********\t", ttl]];
            }
        }
        ttl++;
    }

    isrunning = false;
    // On averti le delegate que le traceroute est terminé.
    [_delegate traceRouteDidEnd];
    return error;
}

/**
 * 停止traceroute
 */
- (void)stopTrace
{
    @synchronized(running)
    {
        isrunning = false;
    }
}


/**
 * 检测traceroute是否在运行
 */
- (bool)isRunning
{
    return isrunning;
}
@end
