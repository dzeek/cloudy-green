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
static void *M2DocumentKVOContext;

- (void) startObservingPerson:(id)m2person
{
    [m2person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld context:&M2DocumentKVOContext];
    [m2person addObserver:self forKeyPath:@"hourlyRate" options:NSKeyValueObservingOptionOld context:&M2DocumentKVOContext];
}

- (void) stopObservingPerson:(id)m2person
{
    [m2person removeObserver:self forKeyPath:@"name" context:&M2DocumentKVOContext];
    [m2person removeObserver:self forKeyPath:@"hourlyRate" context:&M2DocumentKVOContext];
}

- (void) changeKeyPath:(NSString *)keyPath ofObject:(id)obj toValue:(id)newValue
{
    // setValue:forKeyPath: will cause the key-value observing method
    // to be called, which takes care of teh undo particulars.
    
    [obj setValue:newValue forKeyPath:keyPath];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)changeDict context:(void *)context
{
    if (context != &M2DocumentKVOContext) {
        // no match, skip action
        // [super observeValueForKeyPath:<#keyPath#> ofObject:<#object#> change:changeDict context:<#context#>];
        return;
    }
    NSUndoManager *undo = [self undoManager];
    id oldValue = [changeDict objectForKey:NSKeyValueChangeOldKey];
    if ([NSNull null] == oldValue) {
        oldValue = nil;
    }
    NSLog(@"oldValue = %@", oldValue);
    [[undo prepareWithInvocationTarget:self] changeKeyPath:keyPath ofObject:object toValue:oldValue];
    [undo setActionName:@"Edit"];
}
- (id)init
{
    self = [super init];
    if (self) {
    
        _meeting = [[M2Meeting alloc] init];
       
    }
    return self;
}


- (void) dealloc
{
    [_meeting release];
    _meeting = nil;
    
    [_currentTimeLabel release];
    _currentTimeLabel = nil;

    [_elapsedTimeLabel release];
    _elapsedTimeLabel = nil;

    [_accruedCostLabel release];
    _accruedCostLabel = nil;

    [_totalBillTargetActionLabel release];
    _totalBillTargetActionLabel = nil;

    [_totalBillBindingKvoLabel release];
    _totalBillBindingKvoLabel = nil;

    [_totalBillArrayBindingLabel release];
    _totalBillArrayBindingLabel = nil;

    [_meetStartTime release];
    _meetStartTime = nil;

    [_meetEndTimeLabel release];
    _meetEndTimeLabel = nil;

    [_startMeetingButton release];
    _startMeetingButton = nil;

    [_endMeetingButton release];
    _endMeetingButton = nil;

    [_addParticipantButton release];
    _addParticipantButton = nil;

    [_removeParticipantButton release];
    _removeParticipantButton = nil;

    [super dealloc];
}

- (void)insertObject:(M2Person *)object inPersonsPresentAtIndex:(NSUInteger)index
{
    NSLog(@"Document.insertObject:inPersonsPresentAtIndex: NEVER CALLED");
    NSLog(@"Document.insertObject:inPersonsPresentAtIndex: adding %@ to %@", object, [[self meeting] personsPresent]);

    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] removeObjectFromPersonsPresentAtIndex:index];
    if (![undo isUndoing]) {
        [undo setActionName:@"Add Person"];
    }

    [[[self meeting] personsPresent] insertObject:object atIndex:index];
}
-(void)removeObjectFromPersonsPresentAtIndex:(NSUInteger)index
{
    M2Person *m2p = [[[self meeting ]personsPresent] objectAtIndex:index];
    NSLog(@"Meet2Document.removeObjectFromPersonsPresentAtIndex: removing %@ from %@", m2p, [[self meeting]  personsPresent]);

    // add the inverse 
    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] insertObject:m2p inPersonsPresentAtIndex:index];
    if (![undo isUndoing]) {
        [undo setActionName:@"Remove Person"];
    }
    
    [[[self meeting] personsPresent] removeObjectAtIndex:index];
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
- (NSDateFormatter *)meetingDateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter autorelease];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    [usLocale autorelease];

    return dateFormatter;
}

- (IBAction)endMeeting:(id)sender
{
    NSDateFormatter *dateFormatter = [self meetingDateFormatter];
    
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

    [self setTimer:[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateGui:) userInfo:nil repeats:YES]];
    
    // get values from reload if avail
    M2Meeting *meet = [self meeting];
    
    int n_present = (int)[meet countOfPersonsPresent];
    
    if (0 < n_present) {
        // NSLog(@"Doc::windowControllerDidLoadNib: an attended meeting: %@", meet);
        // NSDateFormatter *dateFormatter = [self meetingDateFormatter];
        // NSDate *a_time = [meet startingTime];
        // NSDate *b_time = [meet endingTime];
        // NSLog(@"Doc::windowControllerDidLoadNib: start-time: %@    end-time: %@", a_time, b_time);
        // NSString* start_caption = [dateFormatter stringFromDate:a_time];
        // NSString* ending_caption = [dateFormatter stringFromDate:b_time];

        // NSLog(@"Doc::windowControllerDidLoadNib: Start-caption: %@  ending-caption: %@", start_caption, ending_caption);
        // [[self meetStartTime] setStringValue:@"start_caption"];
        // [[self meetEndTimeLabel] setStringValue:@"ending_caption"];
    }else {
        [[self meetStartTime] setStringValue:@""];
        [[self meetEndTimeLabel] setStringValue:@""];
    }
    
    [[self endMeetingButton] setEnabled:NO];
    
    [self setDisplayName:@"Agile Meeting Tracker"];

    // NSLog(@"end of windowControlllerDidLoadNib, has undo: %u", hasUndoManager());
    [[self meeting] setUndoManager:[self undoManager]];
    [[self meeting] setObserver_manager:self];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    
    return [NSKeyedArchiver archivedDataWithRootObject:self.meeting];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.

    // M2Meeting *newMeeting;
    @try {
        M2Meeting *incoming = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        // NSLog(@"Meet2Document.readFromData: incoming is %@", [incoming className]);
        [[self meeting] setStartingTime:[incoming startingTime]];
        [[self meeting] setEndingTime:[incoming endingTime]];
        NSMutableArray *persons = [incoming personsPresent];
        [[self meeting] setPersonsPresent:persons];
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

    NSDate *start = [[self meeting] startingTime];
    if (nil != start) {
        NSString* start_caption = [[self meetingDateFormatter] stringFromDate:start];
        [[self meetStartTime] setStringValue:start_caption];
    }
    
    NSDate *ending = [[self meeting] endingTime];
    if (nil != ending) {
        NSString* stop_caption = [[self meetingDateFormatter] stringFromDate:ending];
        [[self meetEndTimeLabel] setStringValue:stop_caption];
    }
}

-(id) initWithCoder:(NSCoder *)encoder
{
    self = [super init];
    if (self) {
        _meeting = [[M2Meeting alloc] initWithCoder:encoder];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)encoder
{
    [[self meeting] encodeWithCoder:encoder];
}







@end
