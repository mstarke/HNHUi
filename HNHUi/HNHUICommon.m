//
//  HNHCommon.m
//  MacPass
//
//  Created by Michael Starke on 27/08/14.
//  Copyright (c) 2014 HicknHack Software GmbH. All rights reserved.
//

#import "HNHUICommon.h"

/**
 *  Returns a state for bool flag
 *
 *  @param flag flag to indicate for Off or On state
 *
 *  @return NSStateOn state when flag is YES, NSOffState when flag is NO
 */
NSControlStateValue HNHUIStateForBool(BOOL flag) {
  return flag ? NSControlStateValueOn : NSControlStateValueOff;
}

BOOL HNHUIBoolForState(NSControlStateValue state) {
  switch (state) {
    case NSControlStateValueOn:
      return YES;
    default:
    case NSControlStateValueMixed:
      NSLog(@"Indetermined state!");
    case NSControlStateValueOff:
      return NO;
      break;
  }
}

void HNHUISetStateFromBool(id stateItem, BOOL isOn) {
  if([stateItem respondsToSelector:@selector(setState:)]) {
    [stateItem setState:HNHUIStateForBool(isOn)];
  }
  else {
    NSLog(@"%@ does not respond to setState:", stateItem);
    assert(false);
  }
}


