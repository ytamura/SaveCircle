//
//  DataController.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/09.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "DataController.h"
#import "AppDelegate.h"
#import "Event.h"

@implementation DataController
+(NSInteger)myTotalInteger {
    NSInteger myTotal = 0;
    for (Event* event in SharedAppDelegate.events) {
        if ([event.event_name isEqualToString:@"saved"]) {
            if ([event.user_name isEqualToString:@"Steve"]) {
                myTotal += event.amount_cents/100;
            }
        }
    }
    return myTotal;
}

+(NSInteger)myGroupTotalInteger {
    NSInteger groupTotal = 0;
    for (Event* event in SharedAppDelegate.events) {
        if ([event.event_name isEqualToString:@"saved"]) {
            groupTotal += event.amount_cents/100;
        }
    }
    return groupTotal;
}

+(float)myTotal {
    float myTotal = 0;
    for (Event* event in SharedAppDelegate.events) {
        if ([event.event_name isEqualToString:@"saved"] && [event.user_name isEqualToString:@"Steve"]) {
            myTotal += event.amount_cents/100;
        }
    }
    return myTotal;
}
@end
