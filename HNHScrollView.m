//
//  HNHScrollView.m
//
//  Created by Michael Starke on 28.06.13.
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



#import "HNHScrollView.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#define GRADIENT_OUTER_COLOR
#define GRADIENT_INNER_COLOR

NSString *const HNHScrollViewArchiveKeyLineGradient = @"lineGradient";
NSString *const HNHScrollViewArchiveKeyBorderShadow = @"borderShadow";

@implementation HNHScrollView

/* Initalizerser */
- (id)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];
  if(self) {
    [self _setupGradients];
    _actAsFlipped = NO;
    _showBottomShadow = YES;
    _showTopShadow = YES;
  }
  return self;
}

/* Make shure, if we are loaded from NIBs that we have consistante data */
- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    _actAsFlipped = NO;
    _showBottomShadow = YES;
    _showTopShadow = YES;
    if([aDecoder isKindOfClass:[NSKeyedArchiver class]]) {
      _borderShadow = [aDecoder decodeObjectForKey:HNHScrollViewArchiveKeyBorderShadow];
      _lineGradient = [aDecoder decodeObjectForKey:HNHScrollViewArchiveKeyLineGradient];
    }
    if(!_lineGradient || _borderShadow) {
      _lineGradient = nil;
      _borderShadow = nil;
      [self _setupGradients];
    }
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  if([aCoder isKindOfClass:[NSKeyedArchiver class]]) {
    [aCoder encodeObject:_borderShadow forKey:HNHScrollViewArchiveKeyBorderShadow];
    [aCoder encodeObject:_lineGradient forKey:HNHScrollViewArchiveKeyLineGradient];
  }
}

- (BOOL)isFlipped {
  return _actAsFlipped;
}

- (void)reflectScrolledClipView:(NSClipView *)cView {
  [super reflectScrolledClipView:cView];
  
  
  NSRect documentRect = [[self documentView] frame];
  NSRect visibleRect = [self documentVisibleRect];
  BOOL oldTop = _topClipped;
  BOOL oldBottom = _bottomClipped;
  _topClipped = NSMinY(visibleRect) > 0;
  _bottomClipped = NSMaxY(documentRect) > NSMaxY(visibleRect);
  
  if([[self documentView] isFlipped]) {
    BOOL tmp = _topClipped;
    _topClipped = _bottomClipped;
    _bottomClipped = tmp;
  }
  
  if(_topClipped != oldTop || _bottomClipped != oldBottom) {
    [self setNeedsDisplay:YES];
  }
}

- (void)drawRect:(NSRect)dirtyRect {
  NSRect bounds = [self bounds];
  BOOL showShadow = NO;
  BOOL flipped = [[self documentView] isFlipped];
  BOOL drawTop = _topClipped && ( flipped ? _showBottomShadow : _showTopShadow );
  BOOL drawBottom = _bottomClipped && ( flipped ? _showTopShadow : _showBottomShadow );
  if( drawBottom ) {
    NSRect bottomLine = NSMakeRect(0, NSMaxY(bounds) - 1, NSWidth(bounds), 1);
    [_lineGradient drawInRect:bottomLine angle:0];
    showShadow = YES;
  }
  if( drawTop ) {
    NSRect topLine = NSMakeRect(0, 0, NSWidth(bounds), 1);
    [_lineGradient drawInRect:topLine angle:0];
    showShadow = YES;
  }
  if(showShadow) {
    [NSGraphicsContext saveGraphicsState];
    [_borderShadow set];
    [[NSColor purpleColor] setFill];
    if(drawTop) {
      NSBezierPath *oval = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(0, -10, NSWidth(bounds), 10)];
      [oval fill];
    }
    if(drawBottom) {
      NSBezierPath *oval = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(0, NSMaxY(bounds), NSWidth(bounds), 10)];
      [oval fill];
    }
    [NSGraphicsContext restoreGraphicsState];
  }
}

- (void)_setupGradients {  
  NSArray *lineColors = @[ [NSColor colorWithCalibratedWhite:0.0 alpha:0],
                           [NSColor colorWithCalibratedWhite:0.66 alpha:1],
                           [NSColor colorWithCalibratedWhite:0.66 alpha:1],
                           [NSColor colorWithCalibratedWhite:0.0 alpha:0] ];
  CGFloat lineLocations[] = { 0.0, 0.25, 0.75, 1.0 };
  _lineGradient = [[NSGradient alloc] initWithColors:lineColors atLocations:lineLocations colorSpace:[NSColorSpace deviceGrayColorSpace]];
  
  _borderShadow = [[NSShadow alloc] init];
  [_borderShadow setShadowBlurRadius:6];
  [_borderShadow setShadowColor:[NSColor colorWithCalibratedWhite:0.0 alpha:0.7]];
  [_borderShadow setShadowOffset:NSMakeSize(0, 0)];
}

@end
