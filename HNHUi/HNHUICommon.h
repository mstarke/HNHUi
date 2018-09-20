//
//  HNHCommon.h
//  MacPass
//
//  Created by Michael Starke on 26.02.14.
//  Copyright (c) 2014 HicknHack Software GmbH. All rights reserved.
//

#ifndef HNHUi_HNHUICommon_h
#define HNHUi_HNHUICommon_h

#import <AppKit/AppKit.h>

/**
 *  Returns a state for bool flag
 *
 *  @param flag flag to indicate for Off or On state
 *
 *  @return NSStateOn state when flag is YES, NSOffState when flag is NO
 */
FOUNDATION_EXTERN NSCellStateValue HNHUIStateForBool(BOOL flag);

FOUNDATION_EXTERN BOOL HNHUIBoolForState(NSCellStateValue state);

FOUNDATION_EXTERN void HNHUISetStateFromBool(id stateItem, BOOL isOn);

#endif // HNHUi_HNHUICommon_h
