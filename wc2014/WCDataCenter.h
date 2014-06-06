//
//  WCDataCenter.h
//  wc2014
//
//  Created by lazy on 5/27/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCDataCenter : NSObject

@property (nonatomic, strong) NSArray *schedule;
@property (nonatomic, strong) NSArray *news;

+ (WCDataCenter *)sharedCenter;

- (NSDictionary *)matchInfoAtNumber:(NSInteger)number;


@end
