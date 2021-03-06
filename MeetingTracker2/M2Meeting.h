//
//  M2Meeting.h
//  MeetingTracker2
//
//  Created by Don Zeek on 10/13/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Meet2Document;

@interface M2Meeting : NSObject <NSCoding>
{
    NSDate *_startingTime;
    NSDate *_endingTime;

    NSMutableArray *_personsPresent;
}


// to what degree does this break model independence re: MVC
@property (assign) NSUndoManager *undoManager;
// here is break in model independent
@property (assign) Meet2Document *observer_manager;



- (NSDate *)startingTime;
- (void)setStartingTime:(NSDate *)aStartingTime;
- (NSDate *)endingTime;
- (void)setEndingTime:(NSDate *)anEndingTime;
- (NSMutableArray *)personsPresent;
- (void)setPersonsPresent:(NSMutableArray *)aPersonsPresent;
- (void)addToPersonsPresent:(id)personsPresentObject;
- (void)removeFromPersonsPresent:(id)personsPresentObject;

- (void)removeObjectFromPersonsPresentAtIndex:(NSUInteger)idx;
- (void)insertObject:(id)anObject inPersonsPresentAtIndex:(NSUInteger)idx;

- (NSUInteger)countOfPersonsPresent;
- (NSUInteger)elapsedSeconds;
- (double)elapsedHours;
- (NSString *)elapsedTimeDisplayString;

- (NSNumber *)accruedCost;
- (NSNumber *)totalBillingRate;

+ (M2Meeting *)meetingWithStooges;
+ (M2Meeting *)meetingWithCaptains;
+ (M2Meeting *)meetingWithMarxBrothers;

@end
