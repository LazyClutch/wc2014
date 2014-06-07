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
#import <Social/Social.h>

@interface WCMatchView(){
    BOOL hasEvent;
    NSString *identifier;
    SLComposeViewController *composeViewController;
    NSString *sharedText;
}

@end

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
    self.weiboSharedBtn.hidden = YES;
    composeViewController = [[SLComposeViewController alloc] init];
}

- (void)setMatchView:(NSDictionary *)matchInfo{
    if (matchInfo != nil) {
        
        self.matchInfo = matchInfo;
        
        NSString *no = [matchInfo objectForKey:@"number"];
        NSString *home = [matchInfo objectForKey:@"home"];
        NSString *away = [matchInfo objectForKey:@"away"];
        NSString *location = [matchInfo objectForKey:@"location"];
        NSString *time = [matchInfo objectForKey:@"time"];
        sharedText = [NSString stringWithFormat:@"北京时间%@,欢迎收看%@vs%@",time,home,away];
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
        self.weiboSharedBtn.hidden = NO;
        
        identifier = [[NSUserDefaults standardUserDefaults] stringForKey:no];
        if (identifier == nil) {
            [self.addCalendarBtn setTitle:@"添加到日历及通知" forState:UIControlStateNormal];
            hasEvent = NO;
        } else {
            [self.addCalendarBtn setTitle:@"从日历中删除" forState:UIControlStateNormal];
            hasEvent = YES;
        }
    }
}

- (IBAction)addCalendarPressed:(id)sender {
    EKEventStore *store = [[EKEventStore alloc] init];
    
    NSString *no = [self.matchInfo objectForKey:@"number"];
    NSString *home = [self.matchInfo objectForKey:@"home"];
    NSString *away = [self.matchInfo objectForKey:@"away"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSDate *date = [dateFormatter dateFromString:self.matchTimeLabel.text];
    NSDate *startDate = date;
    NSDate *endDate = [date dateByAddingTimeInterval:120 * 60];
    NSString *name = [NSString stringWithFormat:@"%@ VS %@",home,away];
    if (hasEvent) {
        EKEvent *event = [store eventWithIdentifier:identifier];
        if (event != nil) {
            NSError* error = nil;
            [store removeEvent:event span:EKSpanThisEvent error:&error];
        }
        UIApplication *app = [UIApplication sharedApplication];
        NSArray *localArr = [app scheduledLocalNotifications];
        UILocalNotification *localNoti;
        if (localArr) {
            for (UILocalNotification *noti in localArr) {
                NSDictionary *dict = noti.userInfo;
                if (dict) {
                    NSString *info = [dict objectForKey:no];
                    if ([info isEqualToString:no]) {
                        localNoti = noti;
                        [app cancelLocalNotification:localNoti];
                    }
                }
            }
        }
        [self.addCalendarBtn setTitle:@"添加到日历及通知" forState:UIControlStateNormal];
        hasEvent = NO;
    } else {
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
            EKEvent *myEvent = [EKEvent eventWithEventStore:store];
            myEvent.title = name;
            myEvent.startDate = startDate;
            myEvent.endDate = endDate;
            myEvent.allDay = NO;
            [myEvent setCalendar:[store defaultCalendarForNewEvents]];
            NSError *err;
            [store saveEvent:myEvent span:EKSpanThisEvent error:&err];
            identifier = myEvent.eventIdentifier;
            [[NSUserDefaults standardUserDefaults] setObject:identifier forKey:no];
        }];
        UILocalNotification *noti = [[UILocalNotification alloc] init];
        if (noti) {
            noti.fireDate = [startDate dateByAddingTimeInterval:-60];
            noti.timeZone = [NSTimeZone defaultTimeZone];
            noti.soundName = UILocalNotificationDefaultSoundName;
            noti.alertBody = name;
            NSDictionary *infoDic = [NSDictionary dictionaryWithObject:no forKey:no];
            noti.userInfo = infoDic;
            UIApplication *app = [UIApplication sharedApplication];
            [app scheduleLocalNotification:noti];
        }
        
        [self.addCalendarBtn setTitle:@"从日历中删除" forState:UIControlStateNormal];
        hasEvent = YES;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Complete!" message:@"已将赛程导入日历中" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)weiboSharedBtnPressed:(id)sender {
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6){
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
            composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
            [composeViewController setInitialText:sharedText];
            UIViewController *viewController;
            for (UIView* next = [self superview]; next; next = next.superview) {
                UIResponder *nextResponder = [next nextResponder];
                if ([nextResponder isKindOfClass:[UIViewController class]]) {
                    viewController = (UIViewController *)nextResponder;
                }
            }
            [viewController presentViewController:composeViewController animated:YES completion:nil];
            [composeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
                NSLog(@"start completion block");
                NSString *output;
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        output = @"已取消";
                        break;
                    case SLComposeViewControllerResultDone:
                        output = @"发送成功";
                        break;
                    default:
                        break;
                }
                if (result != SLComposeViewControllerResultCancelled)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Weibo Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                }
            }];

        }
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com"]];
    }
}

@end
