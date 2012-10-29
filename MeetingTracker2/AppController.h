//
//  AppController.h
//  MeetingTracker2
//
//  Created by Don Zeek on 10/27/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import <Foundation/Foundation.h>

@class M2PreferenceController;

@interface AppController : NSObject {
    M2PreferenceController *preferenceController;
}
- (IBAction)showPreferencePanel:(id)sender;
@end
