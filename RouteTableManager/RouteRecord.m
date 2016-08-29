//
//  RouteRecord.m
//  Demo
//
//  Created by jianpx on 8/26/16.
//  Copyright © 2016 . All rights reserved.
//

#import "RouteRecord.h"

// ifaddrs
#import <ifaddrs.h>

// inet
#import <arpa/inet.h>
#include <netinet/in.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/ioctl.h>
#include <stdio.h>


@interface RouteRecord ()
{
    struct sockaddr     m_addrs[RTAX_MAX];
    struct rt_msghdr2   m_rtm;
}

@end

@implementation RouteRecord

- (instancetype)initWithRtm:(struct rt_msghdr2 *)rtm {
    if (!rtm) {
        return nil;
    }
    self = [super init];
    if (self) {
        struct sockaddr* sa = (struct sockaddr*)(rtm + 1);
        memcpy(&(m_rtm), rtm, sizeof(struct rt_msghdr2));
        for (int i = 0; i < RTAX_MAX; i++) {
            [self setAddr:&(sa[i]) index:i];
        }
    }

    return self;

}

- (NSString *)selfDescription {
    NSString *d = [NSString stringWithFormat:@"<%@ %p> dst:%@, gateway:%@, netmask:%@, flags:%@, refs:%ld, use:%ld, mtu:%ld, netif:%@, expire:%ld", NSStringFromClass([self class]), self, self.destination, self.gateway, self.netmask, self.flags, (long)self.refs, (long)self.use, (long)self.mtu, self.netif, (long)self.expire];
    return d;
}

- (NSString *)description {
    return [self selfDescription];
}

- (NSString *)debugDescription {
    return [self selfDescription];
}

- (void)setAddr:(struct sockaddr*)sa index:(int)rtax_index
{
    if(rtax_index >= 0 && rtax_index < RTAX_MAX)
    {
        memcpy(&(m_addrs[rtax_index]), sa, sizeof(struct sockaddr));
    }
}

- (nullable NSString*)getAddrStringAtIndex:(int)rtaxIndex
{
    NSString * routeString = nil;
    struct sockaddr* sa = &(m_addrs[rtaxIndex]);
    int flagVal = 1 << rtaxIndex;
    
    if(!(m_rtm.rtm_addrs & flagVal))
    {
        return nil;
    }

    if(rtaxIndex >= 0 && rtaxIndex < RTAX_MAX)
    {
        switch(sa->sa_family)
        {
            case AF_INET:
            {
                //sockaddr如果是AF_INET family的话可以转化成sockaddr_in
                struct sockaddr_in* si = (struct sockaddr_in *)sa;
                if(si->sin_addr.s_addr == INADDR_ANY) {
                    routeString = @"default";
                } else {
                    //si->sin_addr是ip地址的整型形式的表示, 可以用inet_ntoa转成x.x.x.x的字符串形式
                    //http://beej.us/guide/bgnet/output/html/multipage/inet_ntoaman.html 提到inet_ntoa不能处理IPV6的地址
                    char *ipAddr = inet_ntoa(si->sin_addr);
                    if (ipAddr != NULL) {
                        routeString = [NSString stringWithCString:ipAddr encoding:NSASCIIStringEncoding];
//                        NSString *netmask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)si->ifa_netmask)->sin_addr)];
//                        int subnet = 0;
//                        if (si->sin_addr.s_addr == INADDR_BROADCAST) {
//                            if (IN_CLASSA(si->sin_addr.s_addr)) {
//                                subnet = IN_CLASSA_NSHIFT;
//                            } else if (IN_CLASSB(si->sin_addr.s_addr)) {
//                                subnet = IN_CLASSB_NSHIFT;
//                            } else if (IN_CLASSC(si->sin_addr.s_addr)) {
//                                subnet = IN_CLASSC_NSHIFT;
//                            } else if (IN_CLASSD(si->sin_addr.s_addr)) {
//                                subnet = IN_CLASSD_NSHIFT;
//                            }
//                            if (subnet != 0) {
//                                routeString = [NSString stringWithFormat:@"%@/%d", routeString, subnet];
//                            }
//                        }
                    }
                }
            }
                break;

            case AF_INET6:
            {
                //http://man7.org/linux/man-pages/man3/inet_ntop.3.html
                struct sockaddr_in6* si = (struct sockaddr_in6 *)sa;
                static const unsigned char localhost_bytes[] =
                { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 };
                if(memcmp(si->sin6_addr.s6_addr, localhost_bytes, 16) == 0) {
                    routeString = @"localhost"; //right?
                } else {
                    //http://beej.us/guide/bgnet/output/html/multipage/inet_ntopman.html
                    char ipStr[INET6_ADDRSTRLEN];
                    const char *ipAddr = inet_ntop(AF_INET6, &(si->sin6_addr), ipStr, INET6_ADDRSTRLEN);
                    if (ipAddr != NULL) {
                        routeString = [NSString stringWithCString:ipAddr encoding:NSASCIIStringEncoding];
                    }
                }
            }
                break;

            case AF_LINK:
            {
                struct sockaddr_dl* sdl = (struct sockaddr_dl*)sa;
                if(sdl->sdl_nlen + sdl->sdl_alen + sdl->sdl_slen == 0)
                {
                    routeString = [NSString stringWithFormat: @"link #%d", sdl->sdl_index];
                } else {
                    routeString = [NSString stringWithCString:link_ntoa(sdl) encoding:NSASCIIStringEncoding];
                }
            }
                break;

            default:
            {
                char a[3 * sa->sa_len];
                char *cp;
                char *sep = "";
                int i;
                
                if(sa->sa_len == 0)
                {
                    routeString = nil;
                }
                else
                {
                    a[0] = '\0';
                    for(i = 0, cp = a; i < sa->sa_len; i++)
                    {
                        cp += sprintf(cp, "%s%02x", sep, (unsigned char)sa->sa_data[i]);
                        sep = ":";
                    }
                    routeString = [NSString stringWithCString:a encoding:NSASCIIStringEncoding];
                }
            }
        }
    }
    
    return routeString;
}

#pragma mark - Getter
- (NSString *)destination {
    return [self getAddrStringAtIndex:RTAX_DST];
}

- (NSString *)gateway {
    return [self getAddrStringAtIndex:RTAX_GATEWAY];
}

- (NSString *)netmask {
    return [self getAddrStringAtIndex:RTAX_NETMASK];
}

- (NSString *)flags {
    NSMutableArray *flagsArray = [NSMutableArray array];
    //https://doc.pfsense.org/index.php/What_do_the_flags_on_the_routing_table_mean
    //https://www.freebsd.org/cgi/man.cgi?query=netstat&sektion=1
    //man netstat to get the relationship

    if (m_rtm.rtm_flags & RTF_UP) {
        [flagsArray addObject:@"U"];
    }
    if (m_rtm.rtm_flags & RTF_GATEWAY) {
        [flagsArray addObject:@"G"];
    }
    if (m_rtm.rtm_flags & RTF_HOST) {
        [flagsArray addObject:@"H"];
    }
    if (m_rtm.rtm_flags & RTF_REJECT) {
        [flagsArray addObject:@"R"];
    }
    if (m_rtm.rtm_flags & RTF_DYNAMIC) {
        [flagsArray addObject:@"D"];
    }
    if (m_rtm.rtm_flags & RTF_MODIFIED) {
        [flagsArray addObject:@"M"];
    }
    if (m_rtm.rtm_flags & RTF_CLONING) {
        [flagsArray addObject:@"C"];
    }
    if (m_rtm.rtm_flags & RTF_XRESOLVE) {
        [flagsArray addObject:@"X"];
    }
    if (m_rtm.rtm_flags & RTF_LLINFO) {
        [flagsArray addObject:@"L"];
    }
    if (m_rtm.rtm_flags & RTF_STATIC) {
        [flagsArray addObject:@"S"];
    }
    if (m_rtm.rtm_flags & RTF_BLACKHOLE) {
        [flagsArray addObject:@"B"];
    }
    if (m_rtm.rtm_flags & RTF_PROTO3) {
        [flagsArray addObject:@"3"];
    }
    if (m_rtm.rtm_flags & RTF_PROTO2) {
        [flagsArray addObject:@"2"];
    }
    if (m_rtm.rtm_flags & RTF_PROTO1) {
        [flagsArray addObject:@"1"];
    }
    if (m_rtm.rtm_flags & RTF_PRCLONING) {
        [flagsArray addObject:@"c"];
    }
    if (m_rtm.rtm_flags & RTF_WASCLONED) {
        [flagsArray addObject:@"W"];
    }
    if (m_rtm.rtm_flags & RTF_BROADCAST) {
        [flagsArray addObject:@"b"];
    }
    if (m_rtm.rtm_flags & RTF_IFSCOPE) {
        [flagsArray addObject:@"I"];
    }
    if (m_rtm.rtm_flags & RTF_IFREF) {
        [flagsArray addObject:@"i"];
    }
    if (m_rtm.rtm_flags & RTF_MULTICAST) {
        [flagsArray addObject:@"m"];
    }
    if (m_rtm.rtm_flags & RTF_ROUTER) {
        [flagsArray addObject:@"r"];
    }
    if (m_rtm.rtm_flags & RTF_PROXY) {
        [flagsArray addObject:@"Y"];
    }

    return [flagsArray componentsJoinedByString:@""];
}

- (NSInteger)refs {
    return m_rtm.rtm_refcnt;
}

- (NSInteger)use {
    return m_rtm.rtm_use;
}

- (NSString *)netif {
    char ifName[IF_NAMESIZE];
    char *name = if_indextoname(m_rtm.rtm_index, ifName);
    if (name != NULL) {
        return [NSString stringWithCString:name encoding:NSASCIIStringEncoding];
    } else {
        return nil;
    }
}

- (NSInteger)expire {
    return m_rtm.rtm_rmx.rmx_expire;
}

- (NSInteger)mtu {
    return m_rtm.rtm_rmx.rmx_mtu;
}
@end
