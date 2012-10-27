//
//  M2ObserverManagerIF.h
//  MeetingTracker2
//
//  Created by Don Zeek on 10/27/12.
//  Copyright (c) 2012 net.dzeek.cp210. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Meet2Document;

@protocol M2ObserverManagerIF <NSObject>
{
    - (void) setObserverManager:(Meet2Document *)mgr;
    - (Meet2Document *)observerManager;
}

@end
