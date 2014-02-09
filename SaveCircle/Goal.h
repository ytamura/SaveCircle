//
//  Goal.h
//  SaveCircle
//
//  Created by Ian Wong on 2/8/14.
//  Copyright (c) 2014 FinCapDev Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goal : NSObject

@property(nonatomic) NSString *name;
@property(nonatomic) NSInteger goal_amount_cents;
@property(nonatomic) NSInteger amount_cents_so_far;


@end
