//
//  NSWindow+Shake.m
//  MacPass
//
//  Created by Michael Starke on 21.02.14.
//  Copyright (c) 2014 HicknHack Software GmbH. All rights reserved.
//
//  Code derived from NSWindow+Shake https://github.com/stal888/Poison copyright Sebastian Bergstein
//  licensed under GPLv3

#import "NSWindow+HNHUIShake.h"
#import <QuartzCore/QuartzCore.h>

static NSUInteger const _kNumberOfShakes = 2; // Amout of shakes to perform
static CGFloat const _kShakeStrength = 0.005; // Percentage of shake strenght
static CGFloat const _kShakeDuration = 0.4;

@implementation NSWindow (HNHUIShake)

- (void)shakeWindow:(void (^)(void))completionHandler {
  self.animations = @{@"frameOrigin": [self _shakeAnimation:self.frame]};
  [self.animator setFrameOrigin:self.frame.origin];
  if (completionHandler) {
    double delayInSeconds = _kShakeDuration;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      completionHandler();
    });
  }
}

- (CAKeyframeAnimation *)_shakeAnimation:(NSRect)frame {
  CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animation];
  CGMutablePathRef shakePath = CGPathCreateMutable();
  CGPathMoveToPoint(shakePath, NULL, NSMinX(frame), NSMinY(frame));
	for (int index = 0; index < _kNumberOfShakes; index++) {
		CGPathAddLineToPoint(shakePath, NULL, NSMinX(frame) - frame.size.width * _kShakeStrength, NSMinY(frame));
		CGPathAddLineToPoint(shakePath, NULL, NSMinX(frame) + frame.size.width * _kShakeStrength, NSMinY(frame));
	}
  CGPathCloseSubpath(shakePath);
  shakeAnimation.path = shakePath;
  shakeAnimation.duration = _kShakeDuration;
  CGPathRelease(shakePath);
  return shakeAnimation;
}

@end
