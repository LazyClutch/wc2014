//
//  WCDataCenter.m
//  wc2014
//
//  Created by lazy on 5/27/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import "WCDataCenter.h"

@implementation WCDataCenter

WCDataCenter *sharedCenter = nil;

+ (WCDataCenter *)sharedCenter{
    if (sharedCenter == nil) {
        sharedCenter = [[WCDataCenter alloc] init];
    }
    return sharedCenter;
}

- (NSDictionary *)matchInfoAtNumber:(NSInteger)number{
    return [self.schedule objectAtIndex:number];
}

@end
