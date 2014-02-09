//
//  DataController.h
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/09.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject
+(NSInteger)myTotalInteger;
+(NSInteger)myGroupTotalInteger;
+(float)myTotal;
+(NSInteger)amount_cents_so_far_in_goal:(NSInteger)goal_id;
@end
