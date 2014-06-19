//
//  WCNewsViewController.h
//  wc2014
//
//  Created by lazy on 6/18/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshView.h"

@interface WCNewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,PullToRefreshViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *returnBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)returnBtnPressed:(id)sender;
- (void)setFirstLoad;

@end
