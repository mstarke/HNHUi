//
//  HNHCommon.m
//  MacPass
//
//  Created by Michael Starke on 27/08/14.
//  Copyright (c) 2014 HicknHack Software GmbH. All rights reserved.
//

#import "HNHCommon.h"

/**
 *  Returns a state for bool flag
 *
 *  @param flag flag to indicate for Off or On state
 *
 *  @return NSStateOn state when flag is YES, NSOffState when flag is NO
 */
NSInteger HNHStateForBool(BOOL flag) {
  return flag ? NSOnState : NSOffState;
}

BOOL HNHBoolForState(NSInteger state) {
  switch (state) {
    case NSOnState:
      return YES;
    default:
    case NSMixedState:
      NSLog(@"Indetermined state!");
    case NSOffState:
      return NO;
      break;
  }
}

void HNHSetStateFromBool(id stateItem, BOOL isOn) {
  if([stateItem respondsToSelector:@selector(setState:)]) {
    [stateItem setState:HNHStateForBool(isOn)];
  }
  else {
    NSLog(@"%@ does not respond to setState:", stateItem);
    assert(false);
  }
}

BOOL HNHIsRunningOnYosemiteOrNewer() {
  return floor(NSAppKitVersionNumber) >= NSAppKitVersionNumber10_10;
}
