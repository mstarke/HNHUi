//
//  HNHCommon.h
//  MacPass
//
//  Created by Michael Starke on 26.02.14.
//  Copyright (c) 2014 HicknHack Software GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Returns a state for bool flag
 *
 *  @param flag flag to indicate for Off or On state
 *
 *  @return NSStateOn state when flag is YES, NSOffState when flag is NO
 */
static NSInteger HNHStateForBool(BOOL flag) {
  return flag ? NSOnState : NSOffState;
}