//
//  M2PreferenceController.m
//  MeetingTracker2
//
//  Created by Don Zeek on 10/27/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import "M2PreferenceController.h"

NSString * const dz_BillingRateKey = @"dz_billing_rate_key";

@interface M2PreferenceController ()
{
    NSNumberFormatter *sldr_v_frmt;
}

@end

@implementation M2PreferenceController

- (id)init
{
    self = [super initWithWindowNibName:@"M2PreferenceController"];
    if (self) {
        sldr_v_frmt = [[NSNumberFormatter alloc] init];
        [sldr_v_frmt setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    return self;
}
- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
//        _billing_rate = [[NSNumber alloc] initWithFloat:180];
    }
    
    return self;
}

- (IBAction)slider_action:(NSSlider *)slider_sender {
    
    float slide_fvalue = [[self rate_slider ] floatValue];
    
    NSNumber *incoming_rate = [[NSNumber alloc] initWithFloat:slide_fvalue];
    // Set the Billing Rate
    [self.class setBillingRate:incoming_rate];
    
    [self updateGui];
}
- (void)setTextToBillingRate
{
    NSString *simple = [sldr_v_frmt stringFromNumber:[self.class billingRate]];
    [[self text_field] setStringValue:simple];
}

- (IBAction)textfield_action:(id)sender {
    // NSLog(@"M2Pref.textfield_action");
    NSTextField *tf = sender;
    NSString *tf_string = [tf stringValue];
    
    NSNumberFormatter *text_n_frmt = [[NSNumberFormatter alloc] init];
    [text_n_frmt setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber *incoming_rate = [text_n_frmt numberFromString:tf_string];
    // Set the Billing Rate
    [self.class setBillingRate:incoming_rate];

    [self updateGui];
}
-(void)updateGui
{
    [self setSliderToBillingRate];
    [self setTextToBillingRate];
}
- (void) setSliderToBillingRate
{
    
    // Get the Billing Rate
    NSNumber *l_billRate = [self.class billingRate];
    [[self rate_slider] setFloatValue:[l_billRate floatValue]];
    
}

- (IBAction)changeHourlyRate:(id)sender
{
    NSLog(@"sender class/NSScriptClassCode: %u", [sender classCode]);
    NSLog(@"M2PreferenceController.changeHourlyRate: sender class: %@", [sender class]);
}

+ (void) setBillingRate:(NSNumber *) a_new_rate
{
//    [_billing_rate setValue:a_new_rate];
//    [self setSliderToBillingRate];
//    [self setTextToBillingRate];
    [[NSUserDefaults standardUserDefaults] setObject:a_new_rate forKey:dz_BillingRateKey];
}
+ (NSNumber *) billingRate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *defaultBillingRate = [defaults objectForKey:dz_BillingRateKey];
    
    // NSLog(@"M2Prefs+billingRate: rate: %@", defaultBillingRate);
    
    return defaultBillingRate;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    NSLog(@"M2PreferenceController.windowDidLoad: Nib file did load");

//    NSNumber *expected_rate = [[NSNumber alloc] initWithFloat:185.00];
//    [self set_billing_rate:expected_rate];
    [self setSliderToBillingRate];
    [self setTextToBillingRate];
//    [[self rate_slider] setFloatValue:[[self billingRate] floatValue]];

}

@end
