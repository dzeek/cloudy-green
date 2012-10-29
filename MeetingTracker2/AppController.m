//
//  AppController.m
//  MeetingTracker2
//
//  Created by Don Zeek on 10/27/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import "AppController.h"
#import "M2PreferenceController.h"

@implementation AppController

+ (void)initialize
{
    // create the dictionary
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    
    // Archive the default bill rate
    NSNumber *defBillRate = [[NSNumber alloc] initWithFloat:125.00];
    [defaultValues setObject:defBillRate forKey:dz_BillingRateKey];
    
    // Regeister the dictionary of defaults
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    NSLog(@"AppController.initialize: registered defaults: %@", defaultValues);
}
- (IBAction)showPreferencePanel:(id)sender
{
     // is M2Pref nil?
    if (!preferenceController) {
        preferenceController = [[M2PreferenceController alloc] init];
    }
    NSLog(@"showing %@", preferenceController);
    [preferenceController showWindow:self];
}
@end
