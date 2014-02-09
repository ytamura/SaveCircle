//
//  FirstViewController.h
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *feedtable;
@property (strong, nonatomic) IBOutlet UIButton *add_button;
@property (strong, nonatomic) IBOutlet UIButton *my_total_button;
@property (strong, nonatomic) IBOutlet UIButton *team_total_button;

- (IBAction)tap_like:(id)sender;

@end
