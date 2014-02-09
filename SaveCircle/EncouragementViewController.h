//
//  EncouragementViewController.h
//  SaveCircle
//
//  Created by Ian Wong on 2/8/14.
//  Copyright (c) 2014 FinCapDev Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EncouragementViewController : UIViewController

@property Event *event;
@property (weak, nonatomic) IBOutlet UITextView *encourageTextView;

@end
