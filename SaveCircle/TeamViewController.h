//
//  TeamViewController.h
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/09.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *okButton;
@property (strong, nonatomic) IBOutlet UIButton *totalSaved;

- (IBAction)tap_ok:(id)sender;
@end
