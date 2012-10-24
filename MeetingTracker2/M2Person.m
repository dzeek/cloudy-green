//
//  M2Person.m
//  MeetingTracker2
//
//  Created by Don Zeek on 10/13/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import "M2Person.h"

@implementation M2Person

- (void) initWithEncoder:(NSCoder *)encoder
{
    // directly, inside an 'init...'
    [encoder encodeObject:_name forKey:@"personName"];
    [encoder encodeObject:_hourlyRate forKey:@"hourlyRate"];
}

- (void) dealloc
{
    [_name release];
    _name = nil;
    [_hourlyRate release];
    _hourlyRate = nil;
    
    [super dealloc];
}

- (NSString *) description {
    NSString*  ret = [[NSString alloc] initWithFormat:@"Name: %@ - Rate: %@", _name, _hourlyRate];
    [ret autorelease];
    return ret;
}

- (NSString*) name {
    return _name;
}
- (void) setName:(NSString *)aName {
    if (aName != _name) {
        [_name release];
        //  [aName retain];
        _name = [aName copy];
    }
}

- (NSNumber *) hourlyRate {
    return _hourlyRate;
}
- (void)setHourlyRate:(NSNumber *)anHourlyRate {
    if (anHourlyRate != _hourlyRate) {
        [anHourlyRate retain];
        [_hourlyRate release];
        _hourlyRate = anHourlyRate;
    }
}
+ (M2Person *)personWithName:(NSString *)name
                hourlyRate:(double)rate {
    M2Person *ret = [[M2Person alloc] initWithName:name rate:rate];
    [ret autorelease];
    return ret;
}

- (id)initWithName:(NSString*)aParticipantName rate:(double)aRate {
    
    // directly, inside an 'init...'
     self = [super init];
    _name = [aParticipantName copy];
    _hourlyRate = [[NSNumber alloc] initWithDouble:aRate];

    return self;
}


@end
