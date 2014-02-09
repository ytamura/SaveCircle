//
//  FirstViewController.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "FeedViewController.h"
#import "AddSavingViewController.h"
#import "Event.h"

@interface FeedViewController ()

@property(nonatomic) NSMutableArray *events;
@property(nonatomic) NSInteger my_total;
@property(nonatomic) NSInteger team_total;
@property(nonatomic) NSInteger last_event_count;

@end

@implementation FeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //format button
    [self formatAddButton];
    
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
    event3.amount_cents = 500;
    event3.event_name = @"saved";
    event3.created_at = [NSDate date];
    event3.user_name = @"Steve";
    event3.how_long_ago = @"4 days ago";
    event3.user_color = [UIColor purpleColor];
    
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
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateTotals];
    if (self.last_event_count == 0) {
        [self.feedtable reloadData];
    } else if (self.last_event_count != self.events.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.feedtable insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    };
    self.last_event_count = self.events.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)formatAddButton {
    [self.add_button.layer setCornerRadius:28];

    self.add_button.layer.masksToBounds = NO;
    self.add_button.layer.shadowColor = [UIColor grayColor].CGColor;
    self.add_button.layer.shadowOpacity = 0.8;
    self.add_button.layer.shadowRadius = 5;
    self.add_button.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
}

- (void)updateTotals {
    NSInteger myTotal = 0;
    NSInteger groupTotal = 0;
    for (Event* event in self.events) {
        if ([event.event_name isEqualToString:@"saved"]) {
            if ([event.user_name isEqualToString:@"Steve"]) {
                myTotal += event.amount_cents/100;
            }
            groupTotal += event.amount_cents/100;
        }
    }
    
    [self.my_total_button setTitle:[NSString stringWithFormat:@"$%li",(long)myTotal] forState:UIControlStateNormal];
    [self.team_total_button setTitle:[NSString stringWithFormat:@"$%li",(long)groupTotal] forState:UIControlStateNormal];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    
    if (e.liked) {
        UIButton* like_button = (UIButton*)[cell viewWithTag:102];
        [like_button setBackgroundImage:[UIImage imageNamed:@"heart-liked.png"] forState:UIControlStateNormal];
    }
    
    UILabel* agoLabel = (UILabel*)[cell viewWithTag:103];
    [agoLabel setText:e.how_long_ago];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//can like but not unlike
- (IBAction)tap_like:(id)sender {
    UIButton* heart_button = (UIButton*)sender;
    [heart_button setBackgroundImage:[UIImage imageNamed:@"heart-liked.png"] forState:UIControlStateNormal];
}

#pragma Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"AddSaving"]) {
        UINavigationController* navForEntry = (UINavigationController*)[segue destinationViewController];
        AddSavingViewController* addViewController = (AddSavingViewController*)[navForEntry topViewController];
        [addViewController setEvents:self.events];
    }
}



@end
