//
//  AddSavingViewController.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "AddSavingViewController.h"
#import "Goal.h"

@interface AddSavingViewController ()

@property(nonatomic) NSArray *goals;

@end

@implementation AddSavingViewController

- (IBAction)dismiss:(id)sender {
  [self.parentViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  Goal *goal1 = [Goal new];
  goal1.goal_amount_cents = 50000;
  goal1.amount_cents_so_far = 10000;
  goal1.name = @"Mortgage";
  
  Goal *goal2 = [Goal new];
  goal2.goal_amount_cents = 70000;
  goal2.amount_cents_so_far = 5000;
  goal2.name = @"Bling Bling";
  
  self.goals = @[goal1, goal2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SavingsGoalCell" forIndexPath:indexPath];
  
  Goal *goal = [self.goals objectAtIndex:indexPath.row];

  
  UILabel* goalLabel = (UILabel*)[cell viewWithTag:200];
  [goalLabel setText:goal.name];
  
  return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.goals count];
}

@end
