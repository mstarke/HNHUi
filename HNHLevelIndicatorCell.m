//
//  HNHLevelIndicatorCell.m
//  MacPass
//
//  Created by Michael Starke on 09.06.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "HNHLevelIndicatorCell.h"

#define OUTER_RADIUS 8
#define GRADIENT_STOP 0.8

#define BACKGROUND_TOP_COLOR [NSColor colorWithCalibratedWhite:0.7 alpha:1]
#define BACKGROUND_BOTTOM_COLOR [NSColor colorWithCalibratedWhite:0.9 alpha:1]

#define NORMAL_TOP_COLOR [NSColor colorWithCalibratedRed:0.32 green:0.64 blue:0.01 alpha:1]
#define NORMAL_MID_COLOR [NSColor colorWithCalibratedRed:0.42 green:0.82 blue:0.02 alpha:1]
#define NORMAL_BOTTOM_COLOR [NSColor colorWithCalibratedRed:0.25 green:0.5 blue:0.02 alpha:1]

#define NORMAL_STROKE_COLOR [NSColor colorWithCalibratedRed:42.0/255.0 green:100.0/255.0 blue:2.0/255.0 alpha:1]

@interface HNHLevelIndicatorCell () {
@private
  NSGradient *_backgroundGradient;
  NSGradient *_normalGradient;
  NSGradient *_warningGradient;
  NSGradient *_criticalGradient;
}

@end

@implementation HNHLevelIndicatorCell

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    _backgroundGradient = [[NSGradient alloc] initWithColors:@[ BACKGROUND_BOTTOM_COLOR, BACKGROUND_TOP_COLOR] ];
    _normalGradient = [[NSGradient alloc] initWithColorsAndLocations:NORMAL_BOTTOM_COLOR, 0.0, NORMAL_MID_COLOR, GRADIENT_STOP, NORMAL_TOP_COLOR, 1.0, nil];
  
  }
  return self;
}

- (void)dealloc {
  [_backgroundGradient release];
  [_normalGradient release];
  [_warningGradient release];
  [_criticalGradient release];
  [super dealloc];
}


- (NSBezierPath *)strokePathForRect:(NSRect)rect {
  return [NSBezierPath bezierPathWithRoundedRect:rect xRadius:OUTER_RADIUS yRadius:OUTER_RADIUS];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
  
  CGFloat value = 0.0;
  
  if([controlView respondsToSelector:@selector(doubleValue)]) {
    
    value = ([(id)controlView doubleValue] - [self minValue])/ ([self maxValue] - [self minValue]);
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
  [_backgroundGradient drawInBezierPath:outlinePath angle:90];
  if(value > 0.0) {
    NSRect pillRect = NSInsetRect(outlineRect, 2, 2);
    pillRect.size.width *= value;
    NSBezierPath *pillPath = [NSBezierPath bezierPathWithRoundedRect:pillRect xRadius:OUTER_RADIUS-1 yRadius:OUTER_RADIUS-1];
    [NORMAL_STROKE_COLOR setStroke];
    [_normalGradient drawInBezierPath:pillPath angle:90];
    [pillPath stroke];
  }
}
@end
