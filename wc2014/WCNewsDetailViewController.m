//
//  WCNewsDetailViewController.m
//  wc2014
//
//  Created by lazy on 5/26/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import "WCNewsDetailViewController.h"
#import "ProgressHUD.h"
#import <Social/Social.h>

@interface WCNewsDetailViewController (){
    BOOL isLoadSucceed;
    SLComposeViewController *composeViewController;
    
    NSString *newsTitle;
    UIImage *newsImage;
    NSURL *link;
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

- (IBAction)weiboSharedBtnPressed:(id)sender {
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6){
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
            composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
            [composeViewController setInitialText:newsTitle];
            [composeViewController addImage:newsImage];
            [composeViewController addURL:link];
            [self presentViewController:composeViewController animated:YES completion:nil];
            [composeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
                NSLog(@"start completion block");
                NSString *output;
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        output = @"已取消";
                        break;
                    case SLComposeViewControllerResultDone:
                        output = @"发送成功";
                        break;
                    default:
                        break;
                }
                if (result != SLComposeViewControllerResultCancelled)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Weibo Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                }
            }];
            
        }
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com"]];
    }

}

- (void)loadNews:(NSString *)newslink withDetail:(NSDictionary *)info{
    if (!isLoadSucceed) {
        [ProgressHUD show:@"Loading news..."];
    }
    NSString *news = [NSString stringWithFormat:@"%@",newslink];
    NSURL *url = [NSURL URLWithString:news];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
    link = url;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[info objectForKey:@"image"]]];
    newsImage = [UIImage imageWithData:imageData];
    newsTitle = [info objectForKey:@"title"];
    
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
