//
//  AddSavingViewController.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "AddSavingViewController.h"
#import "AppDelegate.h"
#import "Goal.h"
#import "Event.h"

@interface AddSavingViewController ()

@property(nonatomic) UIView *overlay;
@property(nonatomic) NSInteger selected_goal;

@end

static UIColor *overlayColor;

@implementation AddSavingViewController

+ (void)initialize {
  overlayColor = [UIColor colorWithRed:0.2 green:0.8 blue:0.5 alpha:0.8];
}

- (IBAction)dismiss:(id)sender {
  [self.parentViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.venmoButton.layer.borderWidth = 2;
      self.venmoButton.layer.borderColor = [UIColor blackColor].CGColor;
      
      self.paypalButton.layer.borderWidth = 2;
      self.paypalButton.layer.borderColor = [UIColor blackColor].CGColor;
      
      [self.goalTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set default
    self.selected_goal = 0;
  
  // dismiss keyboard
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(dismissKeyboard)];
  [tap setCancelsTouchesInView:NO];
  [self.view addGestureRecognizer:tap];
    
    //format button
    [self.saveButton.layer setCornerRadius:5];
}

- (void)dismissKeyboard {
  [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    // TODO(iw): validate

    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *savingsAdded = [f numberFromString:self.savings_amount.text];

    // Following the hack earlier of a global goals
    Goal *goal = [SharedAppDelegate.goals objectAtIndex:self.selected_goal];
    NSString *goalName = goal.name;

    NSString *alertMessage = [NSString stringWithFormat:@"You are saving $%@ for %@. Are you sure?", savingsAdded, goalName];
    // confirm the amounts
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Confirmation"
                          message: alertMessage
                          delegate: self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:@"Cancel", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
        {
            // pressed OK
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber *savingsAdded = [f numberFromString:self.savings_amount.text];

            Event* newEvent = [Event new];
            newEvent.user_name = @"Selena";
            newEvent.amount_cents = savingsAdded.integerValue * 100;
            newEvent.how_long_ago = @"just now";
            newEvent.user_color = [UIColor purpleColor];
            newEvent.event_name = @"saved";
            newEvent.goal_id = self.selected_goal;

            [self.events insertObject:newEvent atIndex:0];

            [self.parentViewController dismissViewControllerAnimated:YES completion:^{}];
        }
        break;
        case 1:
        {
            // pressed Cancel
        }
        break;
    }
}

- (void)toggleFundingSource:(UIButton *)button {
  UIView *existing = [self.view viewWithTag:201];
  if (existing) {
    [existing removeFromSuperview];
  }
  
  UIView *overlay = [[UIView alloc] initWithFrame:button.bounds];
  overlay.backgroundColor = overlayColor;
  overlay.tag = 201;
  
  [button addSubview:overlay];
}

- (IBAction)paypalTouchUpInside:(id)sender {
  [self toggleFundingSource:sender];
}

- (IBAction)venmoTouchUpInside:(id)sender {
  [self toggleFundingSource:sender];
}

- (IBAction)myCheckingTouchUpInside:(id)sender {
  [self toggleFundingSource:sender];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SavingsGoalCell" forIndexPath:indexPath];
  
  Goal *goal = [SharedAppDelegate.goals objectAtIndex:indexPath.row];

  
  UILabel* goalLabel = (UILabel*)[cell viewWithTag:200];
  [goalLabel setText:goal.name];
  
  return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [SharedAppDelegate.goals count];
}



- (UILabel *)findCheckmark:(UIView *)cell {
  NSArray *subviews = cell.subviews;

  for (int i = 0; i < subviews.count; i++) {
    UIView *subview = (UIView *)cell.subviews[i];
    if (subview.tag == 205) {
      return (UILabel *)subview;
    }
    subview = [self findCheckmark:subview];
    if (subview) {
      return (UILabel *)subview;
    }
  }
  
  return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  // MAJOR HACK
  for (int i = 0; i < [SharedAppDelegate.goals count]; i++) {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    UILabel *label = [self findCheckmark:cell];
    label.textColor = (i == indexPath.row) ? [UIColor blackColor] : [UIColor whiteColor];
  }
    self.selected_goal = indexPath.row;
}

@end
