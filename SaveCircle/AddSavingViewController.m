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
@property(nonatomic) UIView *overlay;

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
  Goal *goal1 = [Goal new];
  goal1.goal_amount_cents = 50000;
  goal1.amount_cents_so_far = 10000;
  goal1.name = @"Mortgage";
  
  Goal *goal2 = [Goal new];
  goal2.goal_amount_cents = 70000;
  goal2.amount_cents_so_far = 5000;
  goal2.name = @"Bling Bling";
  
  self.goals = @[goal1, goal2];
  
  // dismiss keyboard
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(dismissKeyboard)];
  [tap setCancelsTouchesInView:NO];
  [self.view addGestureRecognizer:tap];
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
  NSLog(@"%@", self.savings_amount);
  // TODO(iw): validate
  
  NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
  [f setNumberStyle:NSNumberFormatterDecimalStyle];
  NSNumber *savingsAdded = [f numberFromString:self.savings_amount.text];
  
  NSLog(@"Savings added: %@", savingsAdded);
  
  [self.parentViewController dismissViewControllerAnimated:YES completion:^{}];
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
  for (int i = 0; i < [self.goals count]; i++) {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    UILabel *label = [self findCheckmark:cell];
    NSLog(@"%@", @(i));
    label.textColor = (i == indexPath.row) ? [UIColor blackColor] : [UIColor whiteColor];
    NSLog(@"%@", label.textColor);
  }
}

@end
