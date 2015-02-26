//
//  HNHCommon.h
//  MacPass
//
//  Created by Michael Starke on 26.02.14.
//  Copyright (c) 2014 HicknHack Software GmbH. All rights reserved.
//

#ifndef HNHUi_HNHCommon_h
#define HNHUi_HNHCommon_h

#import <AppKit/AppKit.h>

/**
 *  Returns a state for bool flag
 *
 *  @param flag flag to indicate for Off or On state
 *
 *  @return NSStateOn state when flag is YES, NSOffState when flag is NO
 */
FOUNDATION_EXTERN NSInteger HNHStateForBool(BOOL flag);

FOUNDATION_EXTERN BOOL HNHBoolForState(NSInteger state);

FOUNDATION_EXTERN void HNHSetStateFromBool(id stateItem, BOOL isOn);

FOUNDATION_EXTERN BOOL HNHIsRunningOnYosemiteOrNewer();

#endif