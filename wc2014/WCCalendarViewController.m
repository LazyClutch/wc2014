//
//  WCCalendarViewController.m
//  wc2014
//
//  Created by lazy on 6/18/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import "WCCalendarViewController.h"
#import "WCMatchView.h"
#import "WCDataCenter.h"
#define VIEW_UNIT 256

@interface WCCalendarViewController (){
    NSInteger currNo;
}

@property (nonatomic,strong) WCMatchView *matchView;

@end

@implementation WCCalendarViewController

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
    self.matchView = [[[NSBundle mainBundle] loadNibNamed:@"WCMatchView" owner:self options:nil] objectAtIndex:0];
    [self.matchView setFrame:CGRectMake(0, 0, 1024, 768)];
    [self.view addSubview:self.matchView];
    [self.matchView initView];
    [self.view bringSubviewToFront:self.listView];
    
    //load plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"wcschedule" ofType:@"plist"];
    NSArray *schedule = [NSArray arrayWithContentsOfFile:plistPath];
    [[WCDataCenter sharedCenter] setSchedule:schedule];
    [self.tableView reloadData];
    
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] init];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [leftSwipe addTarget:self action:@selector(leftSwipe:)];
    [self.view addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] init];
    [rightSwipe addTarget:self action:@selector(rightSwipe:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:rightSwipe];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITableView Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[WCDataCenter sharedCenter] schedule] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *match = [[WCDataCenter sharedCenter] matchInfoAtNumber:[indexPath row]];
    NSString *home = [match objectForKey:@"home"];
    NSString *away = [match objectForKey:@"away"];
    NSString *content = [NSString stringWithFormat:@"%@ VS %@",home,away];
    cell.textLabel.text = content;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *match = [[WCDataCenter sharedCenter] matchInfoAtNumber:[indexPath row]];
    [self.matchView setMatchView:match];
}


- (void)rightSwipe:(UIGestureRecognizer *)swipe{
    CGRect newFrame = CGRectMake(0, 0, 256, 768);
    if (self.listView.frame.origin.x == newFrame.origin.x) {
        return;
    }
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [self.listView setFrame:newFrame];
    [UIView commitAnimations];
}

- (void)leftSwipe:(UIGestureRecognizer *)swipe{
    CGRect newFrame = CGRectMake(-256, 0, 256, 768);
    if (self.listView.frame.origin.x == newFrame.origin.x) {
        return;
    }
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [self.listView setFrame:newFrame];
    [UIView commitAnimations];
}

@end
