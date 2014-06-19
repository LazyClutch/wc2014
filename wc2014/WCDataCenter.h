//
//  WCDataCenter.h
//  wc2014
//
//  Created by lazy on 6/18/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCDataCenter : NSObject

@property (nonatomic, strong) NSMutableArray *schedule;
@property (nonatomic, strong) NSMutableArray *news;
@property (nonatomic, strong) NSMutableDictionary *savedEventId;

+ (WCDataCenter *)sharedCenter;

- (NSDictionary *)matchInfoAtNumber:(NSInteger)number;


@end
