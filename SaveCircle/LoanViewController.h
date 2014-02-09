//
//  LoanViewController.h
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *withdraw_button;
@property (strong, nonatomic) IBOutlet UIButton *request_button;
@property (strong, nonatomic) IBOutlet UILabel *your_savings;
@property (strong, nonatomic) IBOutlet UILabel *borrowable;
@property (strong, nonatomic) IBOutlet UILabel *total_available;

@end
