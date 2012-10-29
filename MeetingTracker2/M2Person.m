//
//  M2Person.m
//  MeetingTracker2
//
//  Created by Don Zeek on 10/13/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import "M2Person.h"

@implementation M2Person

- (id) initWithCoder:(NSCoder *)encoder
{
    self = [super init];
    if (self) {
        // directly, inside an 'init...'

        _name = [encoder decodeObjectForKey:@"name"];
        [_name retain];

        _hourlyRate = [encoder decodeObjectForKey:@"hourlyRate"];
        [_hourlyRate retain];

    }
    return self;
}
- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:[self name] forKey:@"name"];
    [encoder encodeObject:[self hourlyRate] forKey:@"hourlyRate"];
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
