//
//  TeamViewController.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/09.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "TeamViewController.h"
#import "DataController.h"

@interface TeamViewController ()

@end

@implementation TeamViewController

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
    
    [self.totalSaved setTitle:[NSString stringWithFormat:@"$%li",(long)[DataController myGroupTotalInteger]] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tap_ok:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
