//
//  M2Person.h
//  MeetingTracker2
//
//  Created by Don Zeek on 10/13/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M2Person : NSObject
{
    NSString *_name;
    NSNumber *_hourlyRate;
}

- (NSString *)name;
- (void)setName:(NSString *)aParticipantName;
- (NSNumber *)hourlyRate;
- (void)setHourlyRate:(NSNumber *)anHourlyRate;

+ (M2Person *)personWithName:(NSString *)name
                hourlyRate:(double)rate;
- (id)initWithName:(NSString*)aParticipantName rate:(double)aRate;

@end
