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
        // [self setMeeting:[[M2Meeting alloc] init]];
        _meeting = [[M2Meeting alloc] init];
       
        // this doesn't work
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
    
    // [self setMeeting:[M2Meeting meetingWithMarxBrothers]];
     
    NSLog(@"logParticipants: %@", [[self meeting] personsPresent]);
    
    for (M2Person* participant in [[self meeting] personsPresent] ) {
        // NSLog(@"logParticipants: participant: %@", [participant description]);
    }
}

- (IBAction)startMeeting:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter autorelease];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    [usLocale autorelease];

    NSDate* now = [[NSDate alloc] init];
    [[self meeting] setStartingTime:now];
    [[self meeting] setEndingTime:nil];
    
    NSString* now_caption = [dateFormatter stringFromDate:now];
    [[self meetStartTime] setStringValue:now_caption];
    [[self meetEndTimeLabel] setStringValue:@""];
    
    [[self startMeetingButton] setEnabled:NO];
    [[self endMeetingButton] setEnabled:YES];
    [[self addParticipantButton] setEnabled:NO];
    [[self removeParticipantButton] setEnabled:NO];
}
- (IBAction)endMeeting:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter autorelease];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    [usLocale autorelease];
    
    NSDate* now = [[NSDate alloc] init];
    [[self meeting] setEndingTime:now];
    
    NSString* now_caption = [dateFormatter stringFromDate:now];
    [[self meetEndTimeLabel] setStringValue:now_caption];
    
    [[self startMeetingButton] setEnabled:YES];
    [[self endMeetingButton] setEnabled:NO];
    [[self addParticipantButton] setEnabled:YES];
    [[self removeParticipantButton] setEnabled:YES];

}


- (NSInteger) numberOfRowsInTableView:(NSTableView *) tv
{
    return [[[self meeting] personsPresent] count];
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
    
    [[self meetStartTime] setStringValue:@""];
    [[self meetEndTimeLabel] setStringValue:@""];
    [[self endMeetingButton] setEnabled:NO];
    
    [self setDisplayName:@"Agile Meeting Tracker"];

    // NSLog(@"after setTimer in windowControlllerDidLoadNib");
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
    // return [NSData data];
    return [NSKeyedArchiver archivedDataWithRootObject:self.meeting];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.

    M2Meeting *newMeeting;
    @try {
        newMeeting = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *e) {
        if (outError) {
            NSDictionary *d = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Data is corrupted.", @"readFromData error reason") forKey:NSLocalizedFailureReasonErrorKey];
            *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:d];
        }
        return NO;
    }
//    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
//    @throw exception;
    return YES;
}

- (void) updateGui:(NSTimer *)the_timer
{

    // with DateFormatter working, use this (likely)
//    [[self currentTimeLabel] setObjectVelue:[NSDate date]];
    
    // if DateFormatter does not respond, use this
    NSDate* now = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    
    NSString* now_caption = [dateFormatter stringFromDate:now];
     // ouput at 5 Hz: NSLog(@"Within updateGui: %@", now_caption);
    [[self currentTimeLabel] setStringValue:now_caption];
    
    int elapsed_seconds = (int)[[self meeting] elapsedSeconds];
    int elapsed_seconds_part = elapsed_seconds % 60;
    int elapsed_minutes = (elapsed_seconds - elapsed_seconds_part)/60;
    int elapsed_minutes_part = elapsed_minutes % 60;
    int elapsed_hours = (elapsed_minutes - elapsed_minutes_part);
    NSString* elapsed_caption = [NSString stringWithFormat:@"%02d:%02d:%02d", elapsed_hours, elapsed_minutes_part, elapsed_seconds_part];
    [[self elapsedTimeLabel] setStringValue:elapsed_caption];
    
    NSNumber* accrued = [[self meeting] accruedCost];
    if (nil != accrued) {
        NSString* accrued_caption = [NSString stringWithFormat:@"$%9.2f", [accrued doubleValue]];
        // NSLog(@"Doc.updateGui: accrued: %@  caption: %@", accrued, accrued_caption);
        [[self accruedCostLabel] setStringValue:accrued_caption];
    }
    
    NSNumber* total_billing = [[self meeting] totalBillingRate];
    if (nil != total_billing) {
        NSString* total_billing_caption = [NSString stringWithFormat:@"$%9.2f", [total_billing doubleValue]];
        [[self totalBillTargetActionLabel] setStringValue:total_billing_caption];
    }
    
    [[self totalBillBindingKvoLabel] setStringValue:@"-"];
    [[self totalBillArrayBindingLabel] setStringValue:@"-"];
}









@end
