//
//  Meet2Document.m
//  MeetingTracker2
//
//  Created by Don Zeek on 10/13/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import "Meet2Document.h"
#import "M2Meeting.h"
#import "M2Person.h"

@interface Meet2Document ()
- (void)setMeeting:(M2Meeting *)a_meeting;
- (NSTimer *) timer;
- (void) setTimer:(NSTimer *)a_timer;

- (void) updateGui:(NSTimer *)the_timer;
@end

@implementation Meet2Document

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        [self setMeeting:[[M2Meeting alloc] init]];
        // NSLog(@"Doc.init: %@", [[self meeting] description] );
        
        // this doesn't work
        // [self setDisplayName:@"Agile Meeting Tracker"];
    }
    return self;
}

- (void) dealloc
{
    [_meeting release];
    _meeting = nil;
    
    [super dealloc];
}

- (M2Meeting *)meeting
{
    return _meeting;
}

- (void)setMeeting:(M2Meeting *)a_meeting
{
    if (a_meeting != _meeting) {
        [a_meeting retain];
        [_meeting release];
        _meeting = a_meeting;
    }
}
- (NSTimer *)timer {
    return _timer;
}

- (void)setTimer:(NSTimer *)a_timer
{
    if (a_timer != _timer) {
        [a_timer retain];
        [_timer invalidate];
        [_timer release];
        _timer = a_timer;
        NSLog(@"Timer set");
    }
}

- (IBAction)logMeeting:(id)sender {
    NSLog(@"Doc.logMeeting: %@", [[self meeting] description] );
}

- (IBAction)logParticipants:(id)sender {
    
    [self setMeeting:[M2Meeting meetingWithMarxBrothers]];
     
    NSLog(@"logParticipants: %@", [[self meeting] personsPresent]);
    
    for (M2Person* participant in [[self meeting] personsPresent] ) {
        NSLog(@"logParticipants: participant: %@", [participant description]);
    }
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Meet2Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    [self setTimer:[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateGui:) userInfo:nil repeats:YES]];
    NSLog(@"after setTimer in windowControlllerDidLoadNib");
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    
    
//    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
//    @throw exception;
//    return nil;
    
    // FIXME: placeholder
    return [NSData data];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

- (void) updateGui:(NSTimer *)the_timer
{

    // with DateFormatter working, use this (likely)
//    [[self currentTimeLabel] setObjectVelue:[NSDate date]];
    
    // if DateFormatter does not respond, use this
     NSDate* now = [[NSDate alloc] init];
     NSString* now_caption = [now description];
     // ouput at 5 Hz: NSLog(@"Within updateGui: %@", now_caption);
    [[self currentTimeLabel] setStringValue:now_caption];
}










@end
