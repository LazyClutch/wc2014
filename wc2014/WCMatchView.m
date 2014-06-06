//
//  WCMatchView.m
//  wc2014
//
//  Created by lazy on 5/21/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import "WCMatchView.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@implementation WCMatchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initView{
    self.VSLabel.hidden = YES;
    self.addCalendarBtn.hidden = YES;
}

- (void)setMatchView:(NSDictionary *)matchInfo{
    if (matchInfo != nil) {
        
        self.matchInfo = matchInfo;
        
        NSString *no = [matchInfo objectForKey:@"number"];
        NSString *home = [matchInfo objectForKey:@"home"];
        NSString *away = [matchInfo objectForKey:@"away"];
        NSString *location = [matchInfo objectForKey:@"location"];
        NSString *time = [matchInfo objectForKey:@"time"];
        self.matchNo.text = no;
        self.matchPlaceLabel.text = location;
        self.matchTimeLabel.text = time;
        self.homeName.text = home;
        self.awayName.text = away;
        NSInteger noInt = [no integerValue];
        if (noInt <= 48) {
            self.matchTypeLabel.text = @"小组赛";
        } else if (noInt <= 56){
            self.matchTypeLabel.text = @"八分之一决赛";
        } else if (noInt <= 60){
            self.matchTypeLabel.text = @"四分之一决赛";
        } else if (noInt <= 62){
            self.matchTypeLabel.text = @"半决赛";
        } else if (noInt <= 63){
            self.matchTypeLabel.text = @"季军争夺战";
        } else if (noInt <= 64){
            self.matchTypeLabel.text = @"决赛";
        }
        self.VSLabel.hidden = NO;
        self.addCalendarBtn.hidden = NO;
    }
}

- (IBAction)addCalendarPressed:(id)sender {
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
        EKEvent *myEvent = [EKEvent eventWithEventStore:store];
        NSString *home = [self.matchInfo objectForKey:@"home"];
        NSString *away = [self.matchInfo objectForKey:@"away"];
        myEvent.title = [NSString stringWithFormat:@"%@ VS %@",home,away];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        NSDate *date = [dateFormatter dateFromString:self.matchTimeLabel.text];
        NSDate *startDate = date;
        NSDate *endDate = [date dateByAddingTimeInterval:120 * 60];
        myEvent.startDate = startDate;
        myEvent.endDate = endDate;
        myEvent.allDay = NO;
        [myEvent setCalendar:[store defaultCalendarForNewEvents]];
        NSError *err;
        [store saveEvent:myEvent span:EKSpanThisEvent error:&err];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Complete!" message:@"已将赛程导入日历中" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }];
}

@end
