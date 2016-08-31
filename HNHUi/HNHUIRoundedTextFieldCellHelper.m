//
//  HNHRoundendTextFieldCellHelper.m
//
//  Created by Michael Starke on 30.06.13.
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

#import "HNHUIRoundedTextFieldCellHelper.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#define CORNER_RADIUS 4.0
#define BUTTON_RADIUS 5.0
#define BUTTON_WIDTH 50.0
#define BUTTON_MARGIN 5.0

@implementation HNHUIRoundedTextFieldCellHelper

+ (NSButtonCell *)copyButtonCell {
  static NSButtonCell *cell = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    cell = [[NSButtonCell alloc] init];
    cell.bezelStyle = NSRoundRectBezelStyle;
    [cell setButtonType:NSMomentaryLightButton];
    cell.controlSize = NSSmallControlSize;
    cell.title = @"Copy";
    cell.bordered = YES;
  });
  return cell;
}

+ (void)drawWithFrame:(NSRect)cellFrame enabled:(BOOL)isEnabled withHighlight:(BOOL)highlight {
  NSBezierPath *strokePath = [self bezelpathForRect:cellFrame withHightlight:highlight];
  [(isEnabled ? [NSColor colorWithCalibratedWhite:0.55 alpha:1] : [NSColor colorWithCalibratedWhite:0.75 alpha:1]) setStroke];
  
  [NSGraphicsContext saveGraphicsState];
  NSShadow *shadow = [[NSShadow alloc] init];
  shadow.shadowOffset = NSMakeSize(0, -1);
  if(highlight) {
    shadow.shadowColor = [NSColor colorWithCalibratedWhite:1 alpha:1];
    shadow.shadowBlurRadius = 1;
    shadow.shadowColor = [NSColor whiteColor];
    [shadow set];
  }
  [[NSColor whiteColor] setFill];
  [strokePath fill];
  
  shadow.shadowColor = [NSColor colorWithCalibratedWhite:0.9 alpha:1];
  shadow.shadowBlurRadius = 1;
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

+ (NSBezierPath *)copyButtonPathForRect:(NSRect)aRect {
  aRect = NSInsetRect(aRect, 4.5, 4.5);
  return [NSBezierPath bezierPathWithRoundedRect:aRect xRadius:BUTTON_RADIUS yRadius:BUTTON_RADIUS];
}

+ (void)drawCopyButtonWithFrame:(NSRect)cellFrame mouseDown:(BOOL)mouseDown controlView:(NSView *)view {
  NSCell *cell = [self copyButtonCell];
  
  CGFloat width = MIN( NSWidth(cellFrame) - BUTTON_MARGIN, BUTTON_WIDTH + BUTTON_MARGIN);
  NSRect buttonRect = NSMakeRect(NSMaxX(cellFrame) - width, NSMinY(cellFrame), width - BUTTON_MARGIN, NSHeight(cellFrame));

  cell.state = mouseDown ? NSOnState : NSOffState;
  cell.highlighted = mouseDown;
  [cell drawWithFrame:buttonRect inView:view];
}

@end
