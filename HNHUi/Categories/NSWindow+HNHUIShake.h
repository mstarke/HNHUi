//
//  NSWindow+Shake.h
//  MacPass
//
//  Created by Michael Starke on 21.02.14.
//  Copyright (c) 2014 HicknHack Software GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSWindow (HNHUIShake)

/**
 *  Shakes the window and runs an optional completion handler after shaking
 *
 *  @param completionHandler Handler to run after shake is done
 */
- (void)shakeWindow:(void (^)(void))completionHandler;

@end
