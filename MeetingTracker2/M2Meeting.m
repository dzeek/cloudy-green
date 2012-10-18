//
//  M2Meeting.m
//  MeetingTracker2
//
//  Created by Don Zeek on 10/13/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import "M2Meeting.h"
#import "M2Person.h"

@interface M2Meeting ()
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

- (void) dealloc {
    [_description release];
    _description = nil;
    [_time_display release];
    _time_display = nil;

    [super dealloc];
}

- (NSString *)description {
    NSString*  ret = [[NSString alloc] initWithString:@"meeting?"];
//    [ret initWithFormat:@"Meeting, start: %@ - stop: %@", _startingTime, _endingTime];
    [ret retain];
    [_description release];
 
    _description = ret;
    return ret;
}

- (NSDate *)startingTime {
    return _startingTime;
}
- (void)setStartingTime:(NSDate *)aStartingTime
{
    [aStartingTime retain];
//    [_startingTime invalidate];
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
    return _personsPresent;
}
- (void)setPersonsPresent:(NSMutableArray *)aPersonsPresent
{
    [aPersonsPresent retain];
    [_personsPresent release];
    _personsPresent = aPersonsPresent;
}
- (void)addToPersonsPresent:(id)personsPresentObject
{
    NSLog(@"M2Meeting::addToPersonsPresent: entry");
    if (nil == _personsPresent) {
        [self setPersonsPresent:[[NSMutableArray alloc] init]];
        NSLog(@"M2Meeting::addToPersonsPresent: Created array");
    }
    [_personsPresent addObject:personsPresentObject];
}
- (void)removeFromPersonsPresent:(id)personsPresentObject
{
    NSLog(@"M2Meeting::removeFromPersonsPresent: entry");
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
        [_personsPresent removeObjectAtIndex:idx];
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
        
        NSLog(@"M2Meeting::insertObject:inPersonsPresentAtIndex: move all items one up, add this");
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
    NSUInteger _time_spent = [_endingTime timeIntervalSince1970] - [_startingTime timeIntervalSince1970];
    NSLog(@"Seconds in meet: %ld", _time_spent);
    return _time_spent;
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
        NSLog(@"Iterating thru meeting: person: %@", [bob_like description] );
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
