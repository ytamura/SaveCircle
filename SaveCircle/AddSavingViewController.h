//
//  AddSavingViewController.h
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSavingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *venmoButton;
@property (weak, nonatomic) IBOutlet UIButton *paypalButton;
@property (weak, nonatomic) IBOutlet UIButton *myAccount;
@property (weak, nonatomic) IBOutlet UITextField *savings_amount;
@property (weak, nonatomic) IBOutlet UITableView *goalTableView;

@end
