//
//  AppDelegate.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "AppDelegate.h"
#import "Goal.h"
#import "Event.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.goals = NSMutableArray.new;
    Goal *goal1 = [Goal new];
    goal1.goal_amount_cents = 50000;
    goal1.amount_cents_so_far = 0; //calculate this instead
    goal1.name = @"Emergency Fund";
    
    Goal *goal2 = [Goal new];
    goal2.goal_amount_cents = 70000;
    goal2.amount_cents_so_far = 0;
    goal2.name = @"Annie's College Fund";
    
    Goal *goal3 = [Goal new];
    goal3.goal_amount_cents = 10000;
    goal3.amount_cents_so_far = 0;
    goal3.name = @"Mortgage Payment";
    
    
    [self.goals addObjectsFromArray:@[goal1, goal2, goal3]];
    
    self.events = [NSMutableArray new];
    
    Event *event = [Event new];
    event.amount_cents = 4500;
    event.event_name = @"saved";
    event.created_at = [NSDate date];
    event.user_name = @"Maria";
    event.how_long_ago = @"1 day ago";
    event.user_color = [UIColor orangeColor];
    
    [self.events addObject:event];
    
    Event *event2 = [Event new];
    event2.amount_cents = 1500;
    event2.event_name = @"saved";
    event2.created_at = [NSDate date];
    event2.user_name = @"Daniel";
    event2.how_long_ago = @"3 days ago";
    event2.user_color = [UIColor greenColor];
    event2.image_name = @"daniel.jpg";
    
    [self.events addObject:event2];
    
    Event *event3 = [Event new];
    event3.amount_cents = 10000;
    event3.event_name = @"saved";
    event3.created_at = [NSDate date];
    event3.user_name = @"Steve";
    event3.how_long_ago = @"4 days ago";
    event3.user_color = [UIColor purpleColor];
    event3.goal_id = 0;
    
    [self.events addObject:event3];
    
    Event *event4 = [Event new];
    event4.amount_cents = 450000;
    event4.event_name = @"set a goal of";
    event4.created_at = [NSDate date];
    event4.user_name = @"Maria";
    event4.how_long_ago = @"2 weeks ago";
    event4.user_color = [UIColor orangeColor];
    event4.liked = YES;
    
    [self.events addObject:event4];
    
    Event *event5 = [Event new];
    event5.amount_cents = 3000;
    event5.event_name = @"saved";
    event5.created_at = [NSDate date];
    event5.user_name = @"Maria";
    event5.how_long_ago = @"2 weeks ago";
    event5.user_color = [UIColor orangeColor];
    
    [self.events addObject:event5];
    
    Event *event6 = [Event new];
    event6.amount_cents = 2300;
    event6.event_name = @"saved";
    event6.created_at = [NSDate date];
    event6.user_name = @"Daniel";
    event6.how_long_ago = @"4 weeks ago";
    event6.user_color = [UIColor greenColor];
    event6.image_name = @"daniel.jpg";
    
    [self.events addObject:event6];
    
    Event *event7 = [Event new];
    event7.amount_cents = 5000;
    event7.event_name = @"saved";
    event7.created_at = [NSDate date];
    event7.user_name = @"Steve";
    event7.how_long_ago = @"4 weeks ago";
    event7.user_color = [UIColor purpleColor];
    event7.goal_id = 1;
    
    [self.events addObject:event7];
    
    Event *event8 = [Event new];
    event8.amount_cents = 3000;
    event8.event_name = @"saved";
    event8.created_at = [NSDate date];
    event8.user_name = @"Steve";
    event8.how_long_ago = @"4 weeks ago";
    event8.user_color = [UIColor purpleColor];
    event8.goal_id = 2;
    
    [self.events addObject:event8];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
