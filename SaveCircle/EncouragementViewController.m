//
//  EncouragementViewController.m
//  SaveCircle
//
//  Created by Ian Wong on 2/8/14.
//  Copyright (c) 2014 FinCapDev Hackathon. All rights reserved.
//

#import "EncouragementViewController.h"

@interface EncouragementViewController ()

@end

@implementation EncouragementViewController

- (IBAction)sendAction:(id)sender {
  [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)dismissAction:(id)sender {
  [self dismissViewControllerAnimated:YES completion:^{}];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void) dismissKeyboard {
  [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  // dismiss keyboard
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(dismissKeyboard)];
  [tap setCancelsTouchesInView:NO];
  [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  self.encourageTextView.text = [NSString stringWithFormat:@"Enter your encouragement for %@", self.event.user_name];
}

@end
