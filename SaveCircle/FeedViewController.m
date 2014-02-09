//
//  FirstViewController.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "FeedViewController.h"
#import "AddSavingViewController.h"
#import "EncouragementViewController.h"
#import "Event.h"
#import "DataController.h"
#import "AppDelegate.h"

@interface FeedViewController ()

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
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateTotals];
    if (self.last_event_count == 0) {
        [self.feedtable reloadData];
    } else if (self.last_event_count != SharedAppDelegate.events.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.feedtable insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    };
  
  
    self.last_event_count = SharedAppDelegate.events.count;
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
    NSInteger myTotal = [DataController myTotalInteger];
    NSInteger groupTotal = [DataController myGroupTotalInteger];
    
    [self.my_total_button setTitle:[NSString stringWithFormat:@"$%li",(long)myTotal] forState:UIControlStateNormal];
    [self.team_total_button setTitle:[NSString stringWithFormat:@"$%li",(long)groupTotal] forState:UIControlStateNormal];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [SharedAppDelegate.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell" forIndexPath:indexPath];
    
    Event* e = [SharedAppDelegate.events objectAtIndex:indexPath.row];
    
    UILabel* feedLabel = (UILabel*)[cell viewWithTag:100];
    float dollars = (float)e.amount_cents / 100;
    NSString* user = e.user_name;
    if ([e.user_name isEqualToString:@"Selena"]) {
        user = @"You";
    }
    
    NSString* labelText = [NSString stringWithFormat:@"%@ %@", user, e.event_name];
    if (dollars > 0) {
        //only show dollar amount if there were dollars involved
        labelText = [NSString stringWithFormat:@"%@ $%.02f", labelText, dollars];
    }
    [feedLabel setText:labelText];
    
    UILabel* avatar = (UILabel*)[cell viewWithTag:101];
    if ([e.image_name length] > 0) {
        [avatar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:e.image_name]]];
        [avatar setText:@""];
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
  
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  
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
        [addViewController setEvents:SharedAppDelegate.events];
    }
  
    else if ([[segue identifier] isEqualToString:@"SendEncouragement"]) {
        NSIndexPath *selectedIndexPath = [self.feedtable indexPathForSelectedRow];
        Event *event = SharedAppDelegate.events[selectedIndexPath.row];
        EncouragementViewController* encouragementViewController = (EncouragementViewController *)[segue destinationViewController];
        [encouragementViewController setEvent:event];
        [self.feedtable deselectRowAtIndexPath:selectedIndexPath animated:NO];
    }
}



@end
