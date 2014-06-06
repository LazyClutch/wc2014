//
//  WCNewsDetailViewController.h
//  wc2014
//
//  Created by lazy on 5/26/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCNewsDetailViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)returnBtnPressed:(id)sender;
- (void)loadNews:(NSString *)newslink;

@end
