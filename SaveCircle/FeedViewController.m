//
//  FirstViewController.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "FeedViewController.h"
#import "Event.h"

@interface FeedViewController ()

@property(nonatomic) NSMutableArray *events;

@end

@implementation FeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.events = [NSMutableArray new];
    
    Event *event = [Event new];
    event.amount_cents = 4500;
    event.event_name = @"saved";
    event.created_at = [NSDate date];
    event.user_name = @"Maria";
    event.user_color = [UIColor orangeColor];

    [self.events addObject:event];

    Event *event2 = [Event new];
    event2.amount_cents = 1500;
    event2.event_name = @"saved";
    event2.created_at = [NSDate date];
    event2.user_name = @"Daniel";
    event2.user_color = [UIColor greenColor];
    event2.image_name = @"daniel.jpg";
    
    [self.events addObject:event2];
    
    Event *event3 = [Event new];
    event3.amount_cents = 500;
    event3.event_name = @"saved";
    event3.created_at = [NSDate date];
    event3.user_name = @"Steve";
    event3.user_color = [UIColor purpleColor];
    
    [self.events addObject:event3];
    
    Event *event4 = [Event new];
    event4.amount_cents = 450000;
    event4.event_name = @"set a goal of";
    event4.created_at = [NSDate date];
    event4.user_name = @"Maria";
    event4.user_color = [UIColor orangeColor];
    
    [self.events addObject:event4];
    
    Event *event5 = [Event new];
    event5.amount_cents = 3000;
    event5.event_name = @"saved";
    event5.created_at = [NSDate date];
    event5.user_name = @"Maria";
    event5.user_color = [UIColor orangeColor];
    
    [self.events addObject:event5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterLongStyle];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell" forIndexPath:indexPath];
    
    Event* e = [self.events objectAtIndex:indexPath.row];
    
    UILabel* feedLabel = (UILabel*)[cell viewWithTag:100];
    float dollars = (float)e.amount_cents / 100;
    NSString* user = e.user_name;
    if ([e.user_name isEqualToString:@"Steve"]) {
        user = @"You";
    }
    NSString* labelText = [NSString stringWithFormat:@"%@ %@ $%.02f", user, e.event_name, dollars];
    [feedLabel setText:labelText];
    
    UILabel* avatar = (UILabel*)[cell viewWithTag:101];
    if ([e.image_name length] > 0) {
        [avatar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:e.image_name]]];
    } else {
        [avatar setBackgroundColor:e.user_color];
        [avatar setText:[[e.user_name capitalizedString] substringToIndex:1]];
    }
    [avatar.layer setCornerRadius:3];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
