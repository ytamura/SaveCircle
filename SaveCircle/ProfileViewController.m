//
//  ProfileViewController.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/09.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "DataController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    
    [self.okButton.layer setCornerRadius:5];
    
    [self.goalSummary setText:[NSString stringWithFormat:@"%lu goals set", (unsigned long)SharedAppDelegate.goals.count]];
    [self.totalSaved setTitle:[NSString stringWithFormat:@"$%li",(long)[DataController myTotalInteger]] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapOk:(id)sender {
      [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
