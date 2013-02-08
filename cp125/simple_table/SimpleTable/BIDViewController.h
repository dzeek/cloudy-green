//
//  BIDViewController.h
//  SimpleTable
//
//  Created by Don Zeek on 1/6/13.
//  Copyright (c) 2013 net.dzeek.cp130. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDViewController : UIViewController

<UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSArray *dwarves;

@end
