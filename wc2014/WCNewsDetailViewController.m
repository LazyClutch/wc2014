//
//  WCNewsDetailViewController.m
//  wc2014
//
//  Created by lazy on 5/26/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import "WCNewsDetailViewController.h"

@interface WCNewsDetailViewController ()

@end

@implementation WCNewsDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnBtnPressed:(id)sender {
    [self.webView loadHTMLString:@"" baseURL:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadNews:(NSString *)newslink{
    NSString *news = [NSString stringWithFormat:@"http://www.fifa.com/%@",newslink];
    NSURL *url = [NSURL URLWithString:news];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark-
#pragma mark UIWebView Delegate Methods
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"连接失败，请检查网络" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alert show];
}
@end
