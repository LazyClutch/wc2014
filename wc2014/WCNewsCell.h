//
//  WCNewsCell.h
//  wc2014
//
//  Created by lazy on 6/18/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

@interface WCNewsCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *newsImage;
@property (strong, nonatomic) IBOutlet UILabel *newsTitle;
@property (strong, nonatomic) IBOutlet UILabel *newsTime;
@property (strong, nonatomic) RTLabel *newsDetail;

- (void)setCell:(NSDictionary *)dict;
- (void)purge;

@end
