//
//  HNHColorWell.m
//  MacPass
//
//  Created by Michael Starke on 30.07.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "HNHColorWell.h"

@implementation HNHColorWell

- (void)drawRect:(NSRect)dirtyRect {
  [[NSColor blueColor] set];
  NSRectFill([self frame]);
}

- (void)drawWellInside:(NSRect)insideRect {
  return;
}

@end
