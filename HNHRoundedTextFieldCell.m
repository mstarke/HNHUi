//
//  HNHRoundedTextFieldCell.m
//
//  Created by Michael Starke on 01.06.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "HNHRoundedTextFieldCell.h"

#define CORNER_RADIUS 4.0

@interface HNHRoundedTextFieldCell ()

/* Creates the bezel path */
- (NSBezierPath *)bezelpathForRect:(NSRect)aRect;

@end

@implementation HNHRoundedTextFieldCell

- (NSBezierPath *)bezelpathForRect:(NSRect)aRect {
  aRect = NSInsetRect(aRect, 0.5, 0.5);
  aRect.size.height -= 1;
  return[NSBezierPath bezierPathWithRoundedRect:aRect xRadius:CORNER_RADIUS yRadius:CORNER_RADIUS];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
  NSBezierPath *strokePath = [self bezelpathForRect:cellFrame];
  [([self isEnabled] ? [NSColor colorWithCalibratedWhite:0.55 alpha:1] : [NSColor colorWithCalibratedWhite:0.75 alpha:1]) setStroke];
  
  [NSGraphicsContext saveGraphicsState];
  NSShadow *shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[NSColor colorWithCalibratedWhite:1 alpha:1]];
  [shadow setShadowOffset:NSMakeSize(0, -1)];
  [shadow setShadowBlurRadius:1];
  [shadow setShadowColor:[NSColor whiteColor]];
  [shadow set];
  
  [[NSColor whiteColor] setFill];
  [strokePath fill];
  
  [shadow setShadowColor:[NSColor colorWithCalibratedWhite:0.9 alpha:1]];
  [shadow setShadowBlurRadius:1];
  [shadow set];
  
  [strokePath setClip];
  [strokePath stroke];
  
  [shadow release];
  
  [NSGraphicsContext restoreGraphicsState];
  
  [strokePath stroke];
  [super drawInteriorWithFrame:cellFrame inView:controlView];
}

/* Set the focusRing to the bezel shape */
- (void)drawFocusRingMaskWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
  [[self bezelpathForRect:cellFrame ] fill];
}

/* We need to pass NO otherwise the roundend corners get rendering artifacts */
- (BOOL)drawsBackground {
  return NO;
}

@end
