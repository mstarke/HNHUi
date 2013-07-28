//
//  HNHRoundendTextFieldCellHelper.m
//  MacPass
//
//  Created by Michael Starke on 30.06.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "HNHRoundedTextFieldCellHelper.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#define CORNER_RADIUS 4.0

@implementation HNHRoundedTextFieldCellHelper

+ (void)drawWithFrame:(NSRect)cellFrame enabled:(BOOL)isEnabled withHighlight:(BOOL)highlight {
  NSBezierPath *strokePath = [self bezelpathForRect:cellFrame withHightlight:highlight];
  [(isEnabled ? [NSColor colorWithCalibratedWhite:0.55 alpha:1] : [NSColor colorWithCalibratedWhite:0.75 alpha:1]) setStroke];
  
  [NSGraphicsContext saveGraphicsState];
  NSShadow *shadow = [[NSShadow alloc] init];
  [shadow setShadowOffset:NSMakeSize(0, -1)];
  if(highlight) {
    [shadow setShadowColor:[NSColor colorWithCalibratedWhite:1 alpha:1]];
    [shadow setShadowBlurRadius:1];
    [shadow setShadowColor:[NSColor whiteColor]];
    [shadow set];
  }
  [[NSColor whiteColor] setFill];
  [strokePath fill];
  
  [shadow setShadowColor:[NSColor colorWithCalibratedWhite:0.9 alpha:1]];
  [shadow setShadowBlurRadius:1];
  [shadow set];
  
  [strokePath addClip];
  [strokePath stroke];
  
  [NSGraphicsContext restoreGraphicsState];
  [strokePath stroke];
}

+ (NSBezierPath *)bezelpathForRect:(NSRect)aRect withHightlight:(BOOL)highlight {
  aRect = NSInsetRect(aRect, 0.5, 0.5);
  if(highlight) {
    aRect.size.height -= 1;
  }
  return[NSBezierPath bezierPathWithRoundedRect:aRect xRadius:CORNER_RADIUS yRadius:CORNER_RADIUS];
}

@end
