//
//  WCMatchView.h
//  wc2014
//
//  Created by lazy on 5/21/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCMatchView : UIView

@property (strong, nonatomic) IBOutlet UIImageView *homeFlag;
@property (strong, nonatomic) IBOutlet UIImageView *awayFlag;
@property (strong, nonatomic) IBOutlet UILabel *homeName;
@property (strong, nonatomic) IBOutlet UILabel *awayName;
@property (strong, nonatomic) IBOutlet UILabel *matchNo;
@property (strong, nonatomic) IBOutlet UILabel *matchTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *matchPlaceLabel;
@property (strong, nonatomic) IBOutlet UIButton *addCalendarBtn;
@property (strong, nonatomic) IBOutlet UILabel *matchTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *VSLabel;
@property (strong, nonatomic) NSDictionary *matchInfo;

- (void)initView;
- (void)setMatchView:(NSDictionary *)matchInfo;
- (IBAction)addCalendarPressed:(id)sender;


@end
