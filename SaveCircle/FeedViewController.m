//
//  FirstViewController.m
//  SaveCircle
//
//  Created by Yuriko Tamura on 2014/02/08.
//  Copyright (c) 2014年 FinCapDev Hackathon. All rights reserved.
//

#import "FeedViewController.h"
#import "Event.h"

@interface FeedViewController ()

@property(nonatomic) NSMutableArray *events;

@end

@implementation FeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.events = [NSMutableArray new];
    
    Event *event = [Event new];
    event.amount_cents = 4500;
    event.event_name = @"saved";

    event.created_at = [NSDate date];
    event.user_name = @"Maria";

    [self.events addObject:event];

    Event *event2 = [Event new];
    event2.amount_cents = 1500;
    event2.event_name = @"saved";
    event2.created_at = [NSDate date];
    event2.user_name = @"Daniel";
    
    [self.events addObject:event2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterLongStyle];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell" forIndexPath:indexPath];
    
    Event* e = [self.events objectAtIndex:indexPath.row];
    
    UILabel* feedLabel = (UILabel*)[cell viewWithTag:100];
    NSString* labelText = [NSString stringWithFormat:@"%@ %@", e.user_name, e.event_name];
    [feedLabel setText:labelText];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
