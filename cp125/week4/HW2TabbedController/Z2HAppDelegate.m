//
//  Z2HAppDelegate.m
//  HW2TabbedController
//
//  Created by Don Zeek on 2/2/13.
//  Copyright (c) 2013 net.dzeek.cp125a. All rights reserved.
//

#import "Z2HAppDelegate.h"

//    #import "Z2HFirstViewController.h"

// #import "Z2HSecondViewController.h"
// #import "Z2HSecondBBViewController.h"
#import "Z2HSecondEmptyViewController.h"
#import "Z2HTabViewController.h"

#import "DZViewController.h"

@implementation Z2HAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // UIViewController *viewController1 = [[Z2HFirstViewController alloc] initWithNibName:@"Z2HFirstViewController" bundle:nil];
    UIViewController *viewController1 = [[DZViewController alloc] initWithNibName:@"DZViewController" bundle:nil];
    
    // UIViewController *viewController2 = [[Z2HSecondViewController alloc] initWithNibName:@"Z2HSecondViewController" bundle:nil];
    // UIViewController *viewController2 = [[Z2HSecondBBViewController alloc] initWithNibName:@"Z2HSecondBBViewController" bundle:nil];
    // UIViewController *viewController2 = [[Z2HSecondBBViewController alloc] init];
    UIViewController *viewController2 = [[Z2HSecondEmptyViewController alloc] init];
    
                                          
    // self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController = [[Z2HTabViewController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
