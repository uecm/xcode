//
//  ViewController.m
//  singleview_schedule
//
//  Created by Egor on 9/4/15.
//  Copyright (c) 2015 Egor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSMutableDictionary *week;
    NSMutableArray *currentDay;
    NSString *currentString;
}
@synthesize container;
@synthesize dayLabel;
@synthesize currentState;
@synthesize schedule;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    
    //Set up date label
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    _dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    //Set up day label
    dateFormatter.dateFormat = @"EEEE";
    dayLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    //Create schedule for current day
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"scheduleList" ofType:@"plist"];
    NSMutableDictionary *scd = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    schedule = [[scd objectForKey:@"week_2"] objectForKey:[dayLabel.text capitalizedString]];
    
    //Set currentState label to current lesson name
    for (NSMutableDictionary *dict in schedule) {
        NSInteger a = [[dict objectForKey:@"order"]integerValue];
        NSInteger b = [self checkForCurrentLesson];
        if (a == b) {
            currentState.text = [dict objectForKey:@"name"];
        }
        else if (b == 123){
            currentState.text = @"ПЕРЕРВА!!!";
        }
        else {
            currentState.text = @"no lessons left";
        }
    }
    
    //Create a list of todays' lessons
    currentDay = [[NSMutableArray alloc] init];

    for (NSDictionary *dict in schedule) {
        NSString *addString = [dict valueForKey:@"name"];
        [currentDay addObject:addString];
    }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailedTableView *vc = [segue destinationViewController];
    [vc setSch:schedule];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [currentDay count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"lessonCell"];
    cell.textLabel.text = [currentDay objectAtIndex:indexPath.row];
    
    for (NSDictionary *dict in schedule) {
        if ([[dict objectForKey:@"name"]isEqualToString:cell.textLabel.text]) {
            if ([[dict objectForKey:@"type"]isEqualToString:@"lection"]) {
                //cell.backgroundColor = [UIColor redColor];
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




#pragma mark - handle time

+ (NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hour];
    [components setMinute:minute];
    return [calendar dateFromComponents:components];
}

- (UILabel*)getDayLabel{
    return dayLabel;
}

-(NSInteger)checkForCurrentLesson{
    
    // 88 means error; 123 means lesson break; 8 means 7th lesson has finished
    
    unsigned int flags =  NSCalendarUnitHour | NSCalendarUnitMinute;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* components = [calendar components:flags fromDate:[NSDate date]];
    NSDate* currentTime = [calendar dateFromComponents:components];
    
    NSDateFormatter *timeFormater = [[NSDateFormatter alloc] init];
    [timeFormater setDateFormat:@"hh:mm"];
   

    NSDate *firstLessonStart = [ViewController dateWithHour:8 minute:00];
    NSDate *firstLessonEnd = [ViewController dateWithHour:9 minute:35];
    //
    NSDate *secondLessonStart = [ViewController dateWithHour:9 minute:50];
    NSDate *secondLessonEnd = [ViewController dateWithHour:11 minute:25];
    //
    NSDate *thirdLessonStart = [ViewController dateWithHour:11 minute:40];
    NSDate *thirdLessonEnd = [ViewController dateWithHour:13 minute:15];
    //
    NSDate *fourthLessonStart = [ViewController dateWithHour:13 minute:30];
    NSDate *fourthLessonEnd = [ViewController dateWithHour:15 minute:05];
    //
    NSDate *fifthLessonStart = [ViewController dateWithHour:15 minute:20];
    NSDate *fifthLessonEnd = [ViewController dateWithHour:16 minute:55];
    //
    NSDate *sixthLessonStart = [ViewController dateWithHour:17 minute:10];
    NSDate *sixthLessonEnd = [ViewController dateWithHour:18 minute:45];
    //
    NSDate *seventhLessonStart = [ViewController dateWithHour:19 minute:00];
    NSDate *seventhLessonEnd = [ViewController dateWithHour:20 minute:35];
    // На 8 пару я ходить не собираюсь.

    switch ([currentTime compare:firstLessonStart]) {
        case NSOrderedAscending:
            return 0;
            break;
        case NSOrderedSame:
            return 1;
            break;
        case NSOrderedDescending:
            if ([currentTime compare:firstLessonEnd] == NSOrderedAscending) {
                return 1;
            }
            break;
        default:
            break;
    }
    
    switch ([currentTime compare:secondLessonStart]) {
        case NSOrderedAscending:
            return 123;
            break;
        case NSOrderedSame:
            return 2;
            break;
        case NSOrderedDescending:
            if ([currentTime compare:secondLessonEnd] == NSOrderedAscending) {
                return 2;
            }
            break;
        default:
            break;
    }
    
    switch ([currentTime compare:thirdLessonStart]) {
        case NSOrderedAscending:
            return 123;
            break;
        case NSOrderedSame:
            return 3;
            break;
        case NSOrderedDescending:
            if ([currentTime compare:thirdLessonEnd] == NSOrderedAscending) {
                return 3;
            }
            break;
        default:
            break;
    }
    switch ([currentTime compare:fourthLessonStart]) {
        case NSOrderedAscending:
            return 123;
            break;
        case NSOrderedSame:
            return 4;
            break;
        case NSOrderedDescending:
            if ([currentTime compare:fourthLessonEnd] == NSOrderedAscending) {
                return 4;
            }
            break;
        default:
            break;
    }
    switch ([currentTime compare:fifthLessonStart]) {
        case NSOrderedAscending:
            return 123;
            break;
        case NSOrderedSame:
            return 5;
            break;
        case NSOrderedDescending:
            if ([currentTime compare:fifthLessonEnd] == NSOrderedAscending) {
                return 5;
            }
            break;
        default:
            break;
    }
    switch ([currentTime compare:sixthLessonStart]) {
        case NSOrderedAscending:
            return 123;
            break;
        case NSOrderedSame:
            return 6;
            break;
        case NSOrderedDescending:
            if ([currentTime compare:sixthLessonEnd] == NSOrderedAscending) {
                return 6;
            }
            break;
        default:
            break;
    }
    switch ([currentTime compare:seventhLessonStart]) {
        case NSOrderedAscending:
            return 123;
            break;
        case NSOrderedSame:
            return 7;
            break;
        case NSOrderedDescending:
            if ([currentTime compare:seventhLessonEnd] == NSOrderedAscending) {
                return 7;
            }
            break;
        default:
            break;
    }
    
    if ([currentTime compare:seventhLessonEnd] == NSOrderedDescending) {
        return 8;
    }
    return 88;
}

@end
