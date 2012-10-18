//
//  Meet2Document.h
//  MeetingTracker2
//
//  Created by Don Zeek on 10/13/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "M2Meeting.h"

@interface Meet2Document : NSDocument
{
    M2Meeting *_meeting;
	NSTimer *_timer;
}
@property (assign) IBOutlet NSTextField *currentTimeLabel;

- (M2Meeting *)meeting;

- (IBAction)logMeeting:(id)sender;
- (IBAction)logParticipants:(id)sender;


@end
