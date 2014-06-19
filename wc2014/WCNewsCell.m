//
//  WCNewsCell.m
//  wc2014
//
//  Created by lazy on 6/18/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import "WCNewsCell.h"

@implementation WCNewsCell

- (void)awakeFromNib
{
    self.newsDetail = [[RTLabel alloc] initWithFrame:CGRectMake(140, 86, 396, 21)];
    [self addSubview:self.newsDetail];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell:(NSDictionary *)dict{
    self.newsTitle.text = [dict objectForKey:@"title"];
    NSString *detail = [dict objectForKey:@"description"];
    self.newsDetail.text = detail;
    NSString *time = [dict objectForKey:@"pubDate"];
    self.newsTime.text = time;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[dict objectForKey:@"image"]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newsImage.image = [UIImage imageWithData:imageData];
        });
    });
}

- (void)purge{
    if (self.newsImage.image != nil) {
        self.newsImage.image = nil;
    }
}

@end
