//
//  HNHLevelIndicatorCell.m
//  MacPass
//
//  Created by Michael Starke on 09.06.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "HNHLevelIndicatorCell.h"

@implementation HNHLevelIndicatorCell

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
  NSRect stroke = NSInsetRect(cellFrame, 0.5, 0.5);
  [[NSColor blackColor] setStroke];
  NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:stroke xRadius:4 yRadius:4];
  [path stroke];
  NSRect pill = NSInsetRect(stroke, 1,1);
  NSBezierPath *pillPath = [NSBezierPath bezierPathWithRoundedRect:pill xRadius:3 yRadius:3];
  [[NSColor greenColor] setStroke];
  [[NSColor blueColor] setFill];
  [pillPath fill];
  [pillPath stroke];
}
@end
