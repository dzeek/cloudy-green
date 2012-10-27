//
//  M2Meeting.m
//  MeetingTracker2
//
//  Created by Don Zeek on 10/13/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import "M2Meeting.h"
#import "M2Person.h"

@interface M2Meeting () <NSCoding>
{
    NSString *_description;
    NSString *_time_display;
    NSUInteger _meetingSize;
}
@end

@implementation M2Meeting

- (id) init {
    self = [super init];
    _personsPresent = [[[NSMutableArray alloc] init] retain];
    return self;
}

-(id)initWithCoder:(NSCoder *)encoder
{
    self = [super init];
    if (self) {
        _startingTime = [encoder decodeObjectForKey:@"startingTime"];
        _endingTime = [encoder decodeObjectForKey:@"endingTime"];

        _personsPresent = [encoder decodeObjectForKey:@"personsPresent"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:[self startingTime] forKey:@"startingTime"];
    [encoder encodeObject:[self endingTime] forKey:@"endingTime"];
    
    [encoder encodeObject:[self personsPresent] forKey:@"personsPresent"];
}

- (void) dealloc {
    [_description release];
    _description = nil;
    [_time_display release];
    _time_display = nil;

    [super dealloc];
}

- (NSString *)description {
    NSString*  ret = [[NSString alloc] init];
    
    ret = [ret stringByAppendingString:@"Meeting!: "];
    
    // [ret initWithFormat:@"Meeting, start: %@ - stop: %@", _startingTime, _endingTime];
    for (M2Person *bob_like in [self personsPresent] )
    {
        // NSLog(@"Iterating thru meeting: person: %@", [bob_like description] );
        NSString* add_a_name = [[bob_like description] stringByAppendingString:@"  "];
        ret = [ret stringByAppendingString:add_a_name];
    }
    [ret autorelease];

    return ret;
}

- (NSDate *)startingTime {
    return _startingTime;
}
- (void)setStartingTime:(NSDate *)aStartingTime
{
    [aStartingTime retain];
    [_startingTime release];
    _startingTime = aStartingTime;

}
- (NSDate *)endingTime
{
    return _endingTime;
}
- (void)setEndingTime:(NSDate *)anEndingTime
{
    [anEndingTime retain];
    [_endingTime release];
    _endingTime = anEndingTime;
}


- (NSMutableArray *)personsPresent
{
    // output at 5 Hz or more ... NSLog(@"M2Meeting.personsPresent: entry");
    return _personsPresent;
}
- (void)setPersonsPresent:(NSMutableArray *)aPersonsPresent
{
    NSLog(@"M2Meeting.setPersonsPresent: entry");
    for (M2Person *m2person in [self personsPresent]) {
        [[self observer_manager] stopObservingPerson:m2person];
    }
    [aPersonsPresent retain];
    [_personsPresent release];
    
    _personsPresent = aPersonsPresent;
    for (M2Person *m2person in [self personsPresent]) {
        [[self observer_manager] startObservingPerson:m2person];
    }
    
}

- (void)addToPersonsPresent:(id)personsPresentObject
{
    NSLog(@"M2Meeting::addToPersonsPresent: entry");
    if (nil == _personsPresent) {
        [self setPersonsPresent:[[NSMutableArray alloc] init]];
        NSLog(@"M2Meeting::addToPersonsPresent: Created array");
    }
    [_personsPresent addObject:personsPresentObject];

    NSLog(@"M2Meeting::addToPersonsPresent: adding to passed-in undoManager");
    [[[self undoManager] prepareWithInvocationTarget:self] removeFromPersonsPresent:personsPresentObject];
}
- (void)removeFromPersonsPresent:(id)personsPresentObject
{
    NSLog(@"M2Meeting::removeFromPersonsPresent: entry");
    
    if (nil != [self observer_manager]) {
        [[self observer_manager] stopObservingPerson:personsPresentObject];        
    }
    if (nil != _personsPresent) {
        [_personsPresent removeObject:personsPresentObject];
    } else {
        NSLog(@"M2Meeting::removeFromPersonsPresent: _personsPresent nil");
    }
}
- (void)removeObjectFromPersonsPresentAtIndex:(NSUInteger)idx
{
    NSLog(@"M2Meeting::removeObjectFromPersonsPresentAtIndex: entry");
    if (nil != _personsPresent) {
        [[self personsPresent] removeObjectAtIndex:idx];

        //  NSLog(@"M2Meeting::removeObjectFromPersonsPresentAtIndex: undo/redo");
        //  [[[self undoManager] prepareWithInvocationTarget:self] removeFromPersonsPresent:personsPresentObject];
    } else {
        NSLog(@"M2Meeting::removeObjectFromPersonsPresentAtIndex: _personsPresent nil");
    }
  
}
- (void)insertObject:(id)anObject inPersonsPresentAtIndex:(NSUInteger)idx
{
    NSLog(@"M2Meeting::insertObject:inPersonsPresentAtIndex: entry");
    if (nil == _personsPresent) {
        [self setPersonsPresent:[[NSMutableArray alloc] init]];
        NSLog(@"M2Meeting::insertObject:inPersonsPresentAtIndex: : Created array");
    } else if (idx > [self countOfPersonsPresent]) {
        NSLog(@"M2Meeting::insertObject:inPersonsPresentAtIndex: index out of range");
    } else {
        
        // NSLog(@"M2Meeting::insertObject:inPersonsPresentAtIndex: move all items one up, add this");
        
        NSLog(@"M2Meeting::insertObject:inPersonsPresentAtIndex: adding to passed-in undoManager");
        [[[self undoManager] prepareWithInvocationTarget:self] removeFromPersonsPresent:anObject];

        // turn on observation
        [[self observer_manager] startObservingPerson:anObject];
        
        // seems like could be parameter checking of some sort, works OK
        [[self personsPresent] insertObject:anObject atIndex:idx];
        
    }
}

- (NSUInteger)countOfPersonsPresent {
    NSUInteger _count = [_personsPresent count];
//    [_count retain];
    //    [_meetingSize invalidate];
//    [_meetingSize release];
    _meetingSize = _count;
    return _meetingSize;
}
- (NSUInteger)elapsedSeconds
{
    NSTimeInterval elapsed_interval = 0.0;

    NSDate* meetStartDate = [self startingTime];
    if (nil != meetStartDate) {
        NSDate* now = [[NSDate alloc] init];

        NSDate* meetEndDate = [self endingTime];
        if (nil == meetEndDate) {
           elapsed_interval = [now timeIntervalSinceDate:meetStartDate];
        } else {
           elapsed_interval = [meetEndDate timeIntervalSinceDate:meetStartDate];
        }
    }
    
    // NSLog(@"Seconds in meet: %f", elapsed_interval);
    return elapsed_interval;
}
- (double)elapsedHours
{
        return ([self elapsedSeconds]/3600.0);
}

- (NSString *)elapsedTimeDisplayString
{
    NSString*  ret = [NSString alloc];
    [ret initWithFormat:@"Meeting lasted: %f hours", [self elapsedHours]];
    [ret autorelease];
    return ret;
}

- (NSNumber *)accruedCost {
    double accrued_cost = [self elapsedHours] * [[self totalBillingRate] doubleValue];
    NSNumber* cost = [[NSNumber alloc] initWithDouble:accrued_cost];
    [cost autorelease];
    return cost;
}
- (NSNumber *)totalBillingRate
{
    double total_billing = 0.0;
    for (M2Person *bob_like in [self personsPresent] )
    {
        // NSLog(@"Meeting.totalBillingRate: iterating thru meeting: person: %@", [bob_like description] );
        total_billing += [[bob_like hourlyRate] doubleValue];
    }
    NSNumber *ret = [[NSNumber alloc] initWithDouble:total_billing];
    return ret;
}

+ (M2Meeting *)meetingWithStooges
{
    M2Meeting* ret = [[M2Meeting alloc] init];
    [ret setStartingTime:[[NSDate alloc] init]];
    // NSString* moe_name = [[NSString alloc] initWithUTF8String:@"moe"];
    // M2Person* moe = [M2Person personWithName:moe_name hourlyRate:5.25];
                  //  initWithUTF8String:@"moe"];
    M2Person* moe = [M2Person personWithName:@"moe" hourlyRate:5.25];
    [ret addToPersonsPresent:moe];
    
    return ret;
}
+ (M2Meeting *)meetingWithCaptains
{
    M2Meeting* ret = [[M2Meeting alloc] init];
    [ret setStartingTime:[[NSDate alloc] init]];

    M2Person* kirk = [M2Person personWithName:@"kirk" hourlyRate:305.25];
    [ret addToPersonsPresent:kirk];
    
    return ret;
}
+ (M2Meeting *)meetingWithMarxBrothers
{
    M2Meeting* ret = [[M2Meeting alloc] init];
    [ret setStartingTime:[[NSDate alloc] init]];
    
    M2Person* groucho = [M2Person personWithName:@"groucho" hourlyRate:305.25];
    [ret addToPersonsPresent:groucho];
    
    return ret;
}


@end
