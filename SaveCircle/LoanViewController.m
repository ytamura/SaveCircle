//
//  LoanViewController.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "LoanViewController.h"
#import "Event.h"
#import "AppDelegate.h"
#import "DataController.h"

@interface LoanViewController ()

@end

@implementation LoanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.withdraw_button.layer setCornerRadius:5];
    [self.request_button.layer setCornerRadius:5];
    
    
    float myTotal = [DataController myTotal];
    
    float availableToBorrow = myTotal * 0.4;
    
    [self.your_savings setText:[NSString stringWithFormat:@"%.02f",myTotal]];
    [self.borrowable setText:[NSString stringWithFormat:@"%.02f",availableToBorrow]];
    [self.total_available setText:[NSString stringWithFormat:@"%.02f",(myTotal+availableToBorrow)]];
    
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

@end
