//
//  HNHLevelIndicatorCell.m
//
//  Created by Michael Starke on 09.06.13.
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

#import "HNHUILevelIndicatorCell.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#define OUTER_RADIUS 8
#define GRADIENT_STOP 0.8

#define BACKGROUND_TOP_COLOR [NSColor colorWithCalibratedWhite:0.7 alpha:1]
#define BACKGROUND_BOTTOM_COLOR [NSColor colorWithCalibratedWhite:0.9 alpha:1]

#define NORMAL_TOP_COLOR [NSColor colorWithCalibratedRed:0.32 green:0.64 blue:0.01 alpha:1]
#define NORMAL_MID_COLOR [NSColor colorWithCalibratedRed:0.42 green:0.82 blue:0.02 alpha:1]
#define NORMAL_BOTTOM_COLOR [NSColor colorWithCalibratedRed:0.25 green:0.5 blue:0.02 alpha:1]
#define NORMAL_STROKE_COLOR [NSColor colorWithCalibratedRed:42.0/255.0 green:100.0/255.0 blue:2.0/255.0 alpha:1]

#define WARNING_TOP_COLOR [NSColor colorWithCalibratedRed:224.0/255.0 green:180.0/255.0 blue:26.0/255.0 alpha:1]
#define WARNING_MID_COLOR [NSColor colorWithCalibratedRed:238.0/255.0 green:230.0/255.0 blue:21.0/255.0 alpha:1]
#define WARNING_BOTTOM_COLOR [NSColor colorWithCalibratedRed:231.0/255.0 green:157.0/255.0 blue:13.0/255.0 alpha:1]
#define WARNING_STROKE_COLOR [NSColor colorWithCalibratedRed:163.0/255.0 green:118.0/255.0 blue:11.0/255.0 alpha:1]

#define CRITICAL_TOP_COLOR [NSColor colorWithCalibratedRed:1.0 green:66.0/255.0 blue:0.0 alpha:1]
#define CRITICAL_MID_COLOR [NSColor colorWithCalibratedRed:1.0 green:0.82 blue:102.0/255.0 alpha:1]
#define CRITICAL_BOTTOM_COLOR [NSColor colorWithCalibratedRed:172.0/255.0 green:48.0/255.0 blue:14.0/255.0 alpha:1]
#define CRITICAL_STROKE_COLOR [NSColor colorWithCalibratedRed:100.0/255.0 green:62.0/255.0 blue:2.0/255.0 alpha:1]

@interface HNHUILevelIndicatorCell () {
@private
  NSGradient *_backgroundGradient;
  NSGradient *_normalGradient;
  NSGradient *_warningGradient;
  NSGradient *_criticalGradient;
}

@end

@implementation HNHUILevelIndicatorCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    _backgroundGradient = [[NSGradient alloc] initWithColors:@[ BACKGROUND_BOTTOM_COLOR, BACKGROUND_TOP_COLOR] ];
    _normalGradient = [[NSGradient alloc] initWithColorsAndLocations:NORMAL_BOTTOM_COLOR, 0.0, NORMAL_MID_COLOR, GRADIENT_STOP, NORMAL_TOP_COLOR, 1.0, nil];
    _warningGradient = [[NSGradient alloc] initWithColorsAndLocations:WARNING_BOTTOM_COLOR, 0.0, WARNING_MID_COLOR, GRADIENT_STOP, WARNING_TOP_COLOR, 1.0, nil];
    _criticalGradient = [[NSGradient alloc] initWithColorsAndLocations:CRITICAL_BOTTOM_COLOR, 0.0, CRITICAL_MID_COLOR, GRADIENT_STOP, CRITICAL_TOP_COLOR, 1.0, nil];;
  
  }
  return self;
}

- (NSBezierPath *)strokePathForRect:(NSRect)rect {
  return [NSBezierPath bezierPathWithRoundedRect:rect xRadius:OUTER_RADIUS yRadius:OUTER_RADIUS];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
  
  CGFloat value = 0.0;
  
  if([controlView respondsToSelector:@selector(doubleValue)]) {
    value = ([(id)controlView doubleValue] - self.minValue)/ (self.maxValue - self.minValue);
    /* Clamp the value */
    value = MAX(0.0, MIN(1.0, value) );
  }
  
  /* calcualte outline rect */
  NSRect outlineRect = NSInsetRect(cellFrame, 0.5, 0.5);
  outlineRect.size.height -= 1;
  outlineRect = NSOffsetRect(outlineRect, 0, 1);
  
  /* Draw highlight
   */
  NSRect highlightRect = NSOffsetRect(outlineRect, 0, -1);
  [[NSColor whiteColor] setStroke];
  [[self strokePathForRect:highlightRect] stroke];
  
  /*
   Draw outline
   */
  [[NSColor darkGrayColor] setStroke];
  NSBezierPath *outlinePath = [self strokePathForRect:outlineRect];
  [outlinePath stroke];
  
  /*
   Draw inside
   */
  NSGradient *fillGradient = _normalGradient;
  NSColor *strokeColor = NORMAL_STROKE_COLOR;
  if(self.doubleValue < self.criticalValue) {
    fillGradient = _criticalGradient;
    strokeColor = CRITICAL_STROKE_COLOR;
  }
  else if(self.doubleValue < self.warningValue) {
    fillGradient = _warningGradient;
    strokeColor = WARNING_STROKE_COLOR;
  }
  
  
  [_backgroundGradient drawInBezierPath:outlinePath angle:90];
  if(value > 0.0) {
    NSRect pillRect = outlineRect; // NSInsetRect(outlineRect, 2, 2);
    pillRect.size.width *= value;
    NSBezierPath *pillPath = [NSBezierPath bezierPathWithRoundedRect:pillRect xRadius:OUTER_RADIUS-1 yRadius:OUTER_RADIUS-1];
    [strokeColor setStroke];
    [fillGradient drawInBezierPath:pillPath angle:90];
    [pillPath stroke];
  }
}
@end
