//
//  WCNewsViewController.h
//  wc2014
//
//  Created by lazy on 5/21/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCNewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *returnBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)returnBtnPressed:(id)sender;

@end
