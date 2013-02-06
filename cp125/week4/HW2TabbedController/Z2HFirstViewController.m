//
//  Z2HFirstViewController.m
//  HW2TabbedController
//
//  Created by Don Zeek on 2/2/13.
//  Copyright (c) 2013 net.dzeek.cp125a. All rights reserved.
//

#import "Z2HFirstViewController.h"

@interface Z2HFirstViewController ()

@end

@implementation Z2HFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
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

@end
