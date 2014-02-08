//
//  Event.h
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
@property (nonatomic) NSInteger amount_cents;
@property (nonatomic) NSString* event_name;
@property (nonatomic) NSDate* created_at;
@property (nonatomic) NSString* user_name;


@end
