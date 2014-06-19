//
//  WCNewsFetcher.m
//  wc2014
//
//  Created by lazy on 6/18/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import "WCNewsFetcher.h"
#import "WCDataCenter.h"

@interface WCNewsFetcher(){
    NSMutableDictionary *newsItem;
    NSMutableString *content;
}

@end

@implementation WCNewsFetcher

static NSString *fifaURL = @"http://www.fifa.com/worldcup/news/rss.xml";

- (void)fetchNews{
    self.fifaNews = [[NSMutableArray alloc] init];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:fifaURL]];
    xmlParser.delegate = self;
    [xmlParser parse];
}

#pragma mark NSXMLParser Delegate Methods

- (void)parserDidStartDocument:(NSXMLParser *)parser{
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [[WCDataCenter sharedCenter] setNews:self.fifaNews];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"item"]) {
        newsItem = [[NSMutableDictionary alloc] init];
    } else if (newsItem != nil){
        content = [[NSMutableString alloc] init];
        if ([elementName isEqualToString:@"enclosure"]){
            NSString *imageUrl = [attributeDict objectForKey:@"url"];
            [newsItem setValue:imageUrl forKey:@"image"];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"item"]) {
        [self.fifaNews addObject:newsItem];
    } else if (newsItem && content){
        [newsItem setValue:content forKey:elementName];
        content = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    if (newsItem && content) {
        content = [[NSMutableString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (newsItem && content) {
        [content appendString:string];
    }
}

@end
