//
//  SecondViewController.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "WishListViewController.h"
#import "AppDelegate.h"
#import "Goal.h"

@interface WishListViewController ()

@end

@implementation WishListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [SharedAppDelegate.goals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoalCell" forIndexPath:indexPath];
    
    Goal* g = [SharedAppDelegate.goals objectAtIndex:indexPath.row];
    
    UILabel* goalLabel = (UILabel*)[cell viewWithTag:300];
    [goalLabel setText:g.name];

    UILabel* goalAmountLabel = (UILabel*)[cell viewWithTag:301];
    NSInteger goalAmount = g.goal_amount_cents / 100;
    [goalAmountLabel setText:[NSString stringWithFormat:@"$%li", (long)goalAmount]];
    
    UIProgressView* goalProgressView = (UIProgressView*)[cell viewWithTag:302];
    float goalPercent = (float)g.amount_cents_so_far / g.goal_amount_cents;
    [goalProgressView setProgress:(float)goalPercent animated:YES];
    
    UILabel* savedAmountLabel = (UILabel*)[cell viewWithTag:303];
    NSInteger savedAmount = g.amount_cents_so_far / 100;
    [savedAmountLabel setText:[NSString stringWithFormat:@"$%li saved", (long)savedAmount]];
    
    UILabel* savedPercentLabel = (UILabel*)[cell viewWithTag:304];
    [savedPercentLabel setText:[NSString stringWithFormat:@"%li%%", (long)goalPercent*100]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
