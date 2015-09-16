//
//  DetailedTableView.h
//  singleview_schedule
//
//  Created by Egor on 9/13/15.
//  Copyright © 2015 Egor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface DetailedTableView : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *sch;



@end
