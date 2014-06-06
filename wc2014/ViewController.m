//
//  ViewController.m
//  wc2014
//
//  Created by lazy on 5/21/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import "ViewController.h"
#import "WCCalendarViewController.h"
#import "WCNewsViewController.h"

@interface ViewController ()

@property (nonatomic, strong) WCCalendarViewController *calendarViewController;
@property (nonatomic, strong) WCNewsViewController *newsViewController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newsBtnPressed:(id)sender {
    if (self.newsViewController == nil){
        self.newsViewController = [[WCNewsViewController alloc] init];
    }
    [self presentViewController:self.newsViewController animated:YES completion:nil];
}

- (IBAction)calendarBtnPressed:(id)sender {
    if (self.calendarViewController == nil) {
        self.calendarViewController = [[WCCalendarViewController alloc] init];
    }
    [self presentViewController:self.calendarViewController animated:YES completion:nil];
}
@end
