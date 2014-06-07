//
//  WCNewsDetailViewController.m
//  wc2014
//
//  Created by lazy on 5/26/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import "WCNewsDetailViewController.h"
#import "ProgressHUD.h"

@interface WCNewsDetailViewController (){
    BOOL isLoadSucceed;
}

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    isLoadSucceed = NO;
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
    if (!isLoadSucceed) {
        [ProgressHUD show:@"Loading news..."];
    }
    NSString *news = [NSString stringWithFormat:@"%@",newslink];
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

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (!isLoadSucceed) {
        [ProgressHUD showSuccess:@"Loading finished!"];
        isLoadSucceed = YES;
    }
}
@end
