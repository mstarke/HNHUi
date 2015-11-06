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

#import "HNHUIScrollView.h"
#import "HNHUICommon.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#define GRADIENT_OUTER_COLOR
#define GRADIENT_INNER_COLOR

NSString *const HNHScrollViewArchiveKeyLineGradient = @"lineGradient";
NSString *const HNHScrollViewArchiveKeyBorderShadow = @"borderShadow";

@interface HNHUIScrollView ()

@property BOOL bottomClipped;
@property BOOL topClipped;
@property (strong) NSGradient *lineGradient;
@property (strong) NSShadow *borderShadow;

@end

@implementation HNHUIScrollView

/* Initalizerser */
- (instancetype)initWithFrame:(NSRect)frameRect {
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
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    _actAsFlipped = NO;
    _showBottomShadow = YES;
    _showTopShadow = YES;
    if([aDecoder isKindOfClass:[NSKeyedArchiver class]]) {
      _borderShadow = [aDecoder decodeObjectForKey:HNHScrollViewArchiveKeyBorderShadow];
      _lineGradient = [aDecoder decodeObjectForKey:HNHScrollViewArchiveKeyLineGradient];
    }
    if(!self.lineGradient || self.borderShadow) {
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
    [aCoder encodeObject:self.borderShadow forKey:HNHScrollViewArchiveKeyBorderShadow];
    [aCoder encodeObject:self.lineGradient forKey:HNHScrollViewArchiveKeyLineGradient];
  }
}

- (BOOL)isFlipped {
  return self.actAsFlipped;
}

- (void)reflectScrolledClipView:(NSClipView *)cView {
  [super reflectScrolledClipView:cView];
  
  
  NSRect documentRect = [self.documentView frame];
  NSRect visibleRect = self.documentVisibleRect;
  BOOL oldTop = self.topClipped;
  BOOL oldBottom = self.bottomClipped;
  self.topClipped = NSMinY(visibleRect) > 0;
  self.bottomClipped = NSMaxY(documentRect) > NSMaxY(visibleRect);
  
  if(((NSView *)self.documentView).flipped) {
    BOOL tmp = self.topClipped;
    self.topClipped = self.bottomClipped;
    self.bottomClipped = tmp;
  }
  
  if(self.topClipped != oldTop || self.bottomClipped != oldBottom) {
    self.needsDisplay = YES;
  }
}

- (void)drawRect:(NSRect)dirtyRect {
  NSRect bounds = self.bounds;
  BOOL showShadow = NO;
  BOOL flipped = [self.documentView isFlipped];
  BOOL drawTop = _topClipped && ( flipped ? _showBottomShadow : _showTopShadow );
  BOOL drawBottom = _bottomClipped && ( flipped ? _showTopShadow : _showBottomShadow );
  if( drawBottom ) {
    NSRect bottomLine = NSMakeRect(0, NSMaxY(bounds) - 1, NSWidth(bounds), 1);
    [self.lineGradient drawInRect:bottomLine angle:0];
    showShadow = YES;
  }
  if( drawTop ) {
    NSRect topLine = NSMakeRect(0, 0, NSWidth(bounds), 1);
    [self.lineGradient drawInRect:topLine angle:0];
    showShadow = YES;
  }
  if(!HNHUIIsRunningOnYosemiteOrNewer() && showShadow ) {
    [NSGraphicsContext saveGraphicsState];
    [self.borderShadow set];
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
  self.lineGradient = [[NSGradient alloc] initWithColors:lineColors atLocations:lineLocations colorSpace:[NSColorSpace deviceGrayColorSpace]];
  
  self.borderShadow = [[NSShadow alloc] init];
  self.borderShadow.shadowBlurRadius = 6;
  self.borderShadow.shadowColor = [NSColor colorWithCalibratedWhite:0.0 alpha:0.7];
  self.borderShadow.shadowOffset = NSMakeSize(0, 0);
}

@end
