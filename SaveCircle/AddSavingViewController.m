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
#import "DataController.h"

@interface AddSavingViewController ()

@property(nonatomic) UIView *overlay;
@property(nonatomic) NSInteger selected_goal;
@property(nonatomic) NSString* selected_source;

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

    NSString *alertMessage = [NSString stringWithFormat:@"You are saving $%@ towards %@ from your %@ account. Are you sure?", savingsAdded, goalName, self.selected_source];
    // confirm the amounts
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Confirmation"
                          message: alertMessage
                          delegate: self
                          cancelButtonTitle:@"Yes"
                          otherButtonTitles:@"No", nil];
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

// validation for the savings amount input field
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // there must be a more elegant way to do this...
    if ([string length] < 1)    // non-visible characters are okay, eg. delete key to delete chars
        return YES;

    // don't allow more than 2 numbers after decimal
    if ([textField.text rangeOfString:@"."].location == [textField.text length] - 3 &&
        ([textField.text length] == range.location || [textField.text length] - 1 == range.location ||
         [textField.text length] - 2 == range.location)){
        return NO;
    }

    // allow only one period
    NSString *validCharacters;
    if  ([textField.text rangeOfString:@"."].location != NSNotFound) {
        validCharacters = @"0123456789";
    } else {
        validCharacters = @"0123456789.";
    }

    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:validCharacters] invertedSet];
    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0);
}

- (void)toggleFundingSource:(UIButton *)button {
  UIView *existing = [self.view viewWithTag:201];
  if (existing) {
    [existing removeFromSuperview];
  }
  
  UIView *overlay = [[UIView alloc] initWithFrame:button.bounds];
  //overlay.backgroundColor = overlayColor;
    overlay.layer.borderWidth = 4;
    overlay.layer.borderColor = [UIColor orangeColor].CGColor;
  overlay.tag = 201;
  
  [button addSubview:overlay];
}

- (IBAction)paypalTouchUpInside:(id)sender {
  [self toggleFundingSource:sender];
    self.selected_source = @"PayPal";
}

- (IBAction)venmoTouchUpInside:(id)sender {
  [self toggleFundingSource:sender];
    self.selected_source = @"Venmo";
}

- (IBAction)myCheckingTouchUpInside:(id)sender {
  [self toggleFundingSource:sender];
    self.selected_source = @"checking";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SavingsGoalCell" forIndexPath:indexPath];
  
  Goal *goal = [SharedAppDelegate.goals objectAtIndex:indexPath.row];
    //NSInteger amount_saved_towards_goal = [DataController amount_cents_so_far_in_goal:indexPath.row];
    //NSInteger amount_needed = goal.goal_amount_cents - amount_saved_towards_goal;
  
  UILabel* goalLabel = (UILabel*)[cell viewWithTag:200];
  [goalLabel setText:[NSString stringWithFormat:@"%@", goal.name]];
  
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
