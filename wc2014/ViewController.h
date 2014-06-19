//
//  ViewController.h
//  wc2014
//
//  Created by lazy on 6/18/14.
//  Copyright (c) 2014 lazy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *logoView;
@property (strong, nonatomic) IBOutlet UIButton *newsBtn;
@property (strong, nonatomic) IBOutlet UIButton *calendarBtn;

- (IBAction)newsBtnPressed:(id)sender;
- (IBAction)calendarBtnPressed:(id)sender;

@end
