//
//  WCNewsViewController.m
//  wc2014
//
//  Created by lazy on 5/21/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import "WCNewsViewController.h"
#import "WCNewsDetailViewController.h"
#import "WCNewsFetcher.h"
#import "WCDataCenter.h"
#import "WCNewsCell.h"
#import "RTLabel.h"

@interface WCNewsViewController (){
    NSArray *newsList;
    BOOL nibRegistered;
}

@property (nonatomic, strong) WCNewsFetcher *newsFetcher;
@property (nonatomic, strong) WCNewsDetailViewController *detailViewController;

@end

@implementation WCNewsViewController

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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.newsFetcher = [[WCNewsFetcher alloc] init];
    [self.newsFetcher fetchNews];
    newsList = [[WCDataCenter sharedCenter] news];
    [self.tableView reloadData];
    nibRegistered = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [newsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    if (!nibRegistered) {
        UINib *nib = [UINib nibWithNibName:@"WCNewsCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        nibRegistered = YES;
    }
    WCNewsCell *cell = (WCNewsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];

    NSDictionary *dict = [newsList objectAtIndex:[indexPath row]];
    [cell setCell:dict];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    WCNewsCell *wcCell = (WCNewsCell *)cell;
    [wcCell purge];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = [newsList objectAtIndex:[indexPath row]];
    NSString *newsLink = [dict objectForKey:@"link"];
    if (self.detailViewController == nil) {
        self.detailViewController = [[WCNewsDetailViewController alloc] init];
    }
    [self presentViewController:self.detailViewController animated:YES completion:^{
        [self.detailViewController loadNews:newsLink];
    }];
}

@end
