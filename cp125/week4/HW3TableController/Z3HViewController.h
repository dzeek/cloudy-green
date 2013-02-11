//
//  Z3HViewController.h
//  HW3TableController
//
//  Created by Don Zeek on 2/7/13.
//  Copyright (c) 2013 net.dzeek.cp125a. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Z3HViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>

@property (copy, nonatomic) NSDictionary *states;
@property (copy, nonatomic) NSArray      *keys;
@property (copy, nonatomic) NSMutableArray      *statesForLetter;



@end
