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
    
    //format
    [self.encourageTextView.layer setCornerRadius:12];
    [self.send_button.layer setCornerRadius:5];
    [self.cancel_button.layer setCornerRadius:5];
    
    //fill event
    [self.toEmail setText:[NSString stringWithFormat:@"%@ %@ $%li",self.event.user_name, self.event.event_name, self.event.amount_cents/100]];
    
    //set avatar
    if ([self.event.image_name length] > 0) {
        [self.toAvatar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:self.event.image_name]]];
    } else {
        [self.toAvatar setBackgroundColor:self.event.user_color];
        [self.toAvatar setText:[[self.event.user_name capitalizedString] substringToIndex:1]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  self.encourageTextView.text = [NSString stringWithFormat:@"Hey %@, I saw that you %@ $%li. Keep up the great work!", self.event.user_name, self.event.event_name, self.event.amount_cents/100];
}

@end
