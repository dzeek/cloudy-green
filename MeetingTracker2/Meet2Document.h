//
//  Meet2Document.h
//
//  Created by Don Zeek on 10/13/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import <Cocoa/Cocoa.h>
// #import "M2Meeting.h"
@class M2Meeting;
@class M2Person;

@interface Meet2Document : NSDocument <NSCoding>
{
    M2Meeting *_meeting;
	NSTimer *_timer;
}
@property (assign) IBOutlet NSTextField *currentTimeLabel;
@property (assign) IBOutlet NSTextField *elapsedTimeLabel;
@property (assign) IBOutlet NSTextField *accruedCostLabel;
@property (assign) IBOutlet NSTextField *totalBillTargetActionLabel;
@property (assign) IBOutlet NSTextField *totalBillBindingKvoLabel;
@property (assign) IBOutlet NSTextField *totalBillArrayBindingLabel;

@property (assign) IBOutlet NSTextField *meetStartTime;
@property (assign) IBOutlet NSTextField *meetEndTimeLabel;
@property (assign) IBOutlet NSButton *startMeetingButton;
@property (assign) IBOutlet NSButton *endMeetingButton;
@property (assign) IBOutlet NSButton *addParticipantButton;
@property (assign) IBOutlet NSButton *removeParticipantButton;

- (void) startObservingPerson:(id)m2person;
- (void) stopObservingPerson:(id) m2person;

- (M2Meeting *)meeting;

- (IBAction)logMeeting:(id)sender;
- (IBAction)logParticipants:(id)sender;

- (IBAction)startMeeting:(id)sender;
- (IBAction)endMeeting:(id)sender;

- (void)insertObject:(M2Person *)object inPersonsPresentAtIndex:(NSUInteger)index;
- (void)removeObjectFromPersonsPresentAtIndex:(NSUInteger)index;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)encoder;

@end
