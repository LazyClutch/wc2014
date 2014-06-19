//
//  WCNewsFetcher.h
//  wc2014
//
//  Created by lazy on 6/18/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCNewsFetcher : NSObject<NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *fifaNews;

- (void)fetchNews;

@end
