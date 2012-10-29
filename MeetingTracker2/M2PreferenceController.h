//
//  M2PreferenceController.h
//  MeetingTracker2
//
//  Created by Don Zeek on 10/27/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const dz_BillingRateKey;

@interface M2PreferenceController : NSWindowController
//{
//    IBOutlet NSTextField *baseHourlyRateText;
//    IBOutlet NSSlider *baseHourlyRateSlider;
//}
@property (assign) IBOutlet NSTextField *text_field;
@property (assign) IBOutlet NSSlider *rate_slider;

// - (NSNumber *)billingRate;

+ (void)setBillingRate:(NSNumber *)a_rate;
+ (NSNumber *) billingRate;

- (IBAction)slider_action:(id)sender;
- (IBAction)textfield_action:(id)sender;


- (IBAction)changeHourlyRate:(id)sender;

@end
