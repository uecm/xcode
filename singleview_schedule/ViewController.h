//
//  ViewController.h
//  singleview_schedule
//
//  Created by Egor on 9/4/15.
//  Copyright (c) 2015 Egor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentState;

@property (strong, nonatomic) NSMutableArray *schedule;


+ (NSDate *)dateWithHour:(NSInteger)year minute:(NSInteger)minute;

@end

