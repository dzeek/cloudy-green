//
//  Z2HAppDelegate.h
//  HW2TabbedController
//
//  Created by Don Zeek on 2/2/13.
//  Copyright (c) 2013 net.dzeek.cp125a. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Z2HAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
