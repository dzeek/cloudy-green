//
//  Z3HDetailViewController.h
//  HW3TableController
//
//  Created by Don Zeek on 2/10/13.
//  Copyright (c) 2013 net.dzeek.cp125a. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Z3HDetailViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSArray      *keys;
@property (copy, nonatomic) NSDictionary      *the_facts;

@end
