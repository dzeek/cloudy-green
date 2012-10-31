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
@property (retain) IBOutlet NSTextField *currentTimeLabel;
@property (retain) IBOutlet NSTextField *elapsedTimeLabel;
@property (retain) IBOutlet NSTextField *accruedCostLabel;
@property (retain) IBOutlet NSTextField *totalBillTargetActionLabel;
@property (retain) IBOutlet NSTextField *totalBillBindingKvoLabel;
@property (retain) IBOutlet NSTextField *totalBillArrayBindingLabel;

@property (retain) IBOutlet NSTextField *meetStartTime;
@property (retain) IBOutlet NSTextField *meetEndTimeLabel;
@property (retain) IBOutlet NSButton *startMeetingButton;
@property (retain) IBOutlet NSButton *endMeetingButton;
@property (retain) IBOutlet NSButton *addParticipantButton;
@property (retain) IBOutlet NSButton *removeParticipantButton;

- (void) startObservingPerson:(id)m2person;
- (void) stopObservingPerson:(id) m2person;

- (M2Meeting *)meeting;

- (IBAction)logMeeting:(id)sender;
- (IBAction)logParticipants:(id)sender;

- (IBAction)startMeeting:(id)sender;
- (IBAction)endMeeting:(id)sender;

- (IBAction)meetingWithMarxBro:(id)sender;
- (IBAction)meetingWithCaptains:(id)sender;

- (void)insertObject:(M2Person *)object inPersonsPresentAtIndex:(NSUInteger)index;
- (void)removeObjectFromPersonsPresentAtIndex:(NSUInteger)index;

//- (void)encodeWithCoder:(NSCoder *)encoder;
//- (id)initWithCoder:(NSCoder *)encoder;

@end
