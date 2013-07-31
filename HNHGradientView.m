//
//  HNHGradientView.m
//
//  Created by Michael Starke on 20.02.13.
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

#import "HNHGradientView.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@interface HNHGradientView ()

@property (assign, nonatomic) BOOL isRenderedActive;

- (void)_refreshActiveState;

@end

@implementation HNHGradientView

- (id)initWithFrame:(NSRect)frameRect {
  NSColor *activeTop = [NSColor colorWithCalibratedWhite:0.85 alpha:1];
  NSColor *activeBottom = [NSColor colorWithCalibratedWhite:0.7 alpha:1];
  NSColor *inactiveTop = [NSColor colorWithCalibratedWhite:0.9 alpha:1];
  NSColor *inactiveBottom = [NSColor colorWithCalibratedWhite:0.85 alpha:1];
  NSGradient *activeGradient = [[NSGradient alloc] initWithColors:@[ activeBottom, activeTop ]] ;
  NSGradient *inactiveGradient = [[NSGradient alloc] initWithColors:@[ inactiveBottom, inactiveTop ]];
  return [self initWithFrame:frameRect activeGradient:activeGradient inactiveGradient:inactiveGradient];
}

- (id)initWithFrame:(NSRect)frame activeGradient:(NSGradient *)activeGradient inactiveGradient:(NSGradient *)inactiveGradient {
  self = [super initWithFrame:frame];
  if(self) {
    _borderType = HNHNoBorder;
    _activeGradient = activeGradient;
    _inactiveGradient = inactiveGradient;
  }
  return self;
}

#pragma mark Drawing

- (void)drawRect:(NSRect)dirtyRect {
  /*
   We draw a Gradient, so make sure we always redraw the full view
   */
  NSRect bounds = [self bounds];
  NSGradient *gradient = self.isRenderedActive ? self.activeGradient : self.inactiveGradient;
  [gradient drawInRect:bounds angle:90];

  if(self.borderType & HNHBorderTop) {
    /* Border at top nees border and highlight */
    [[NSColor grayColor] set];
    NSRect strokeRect = NSMakeRect(NSMinX(bounds), NSMaxY(bounds) - 1, NSWidth(bounds), 1);
    NSRectFill(strokeRect);
    [[NSColor colorWithCalibratedWhite:1 alpha:1] set];
    NSRectFill(NSOffsetRect(strokeRect, 0, -1));
    
  }
  if(self.borderType & HNHBorderBottom) {
    /* Border at bottom needs no highlight */
    [[NSColor grayColor] set];
    NSRect strokeRect = NSMakeRect(NSMinX(bounds), NSMinY(bounds), NSWidth(bounds), 1);
    NSRectFill(strokeRect);
  }
}

- (BOOL)isOpaque {
  return YES;
}

- (void)viewWillMoveToWindow:(NSWindow *)newWindow {
  [self _registerWindow:newWindow];
  self.isRenderedActive = [newWindow isKeyWindow];
  [super viewWillMoveToWindow:newWindow];
}

#pragma mark State Refresh
- (void)_registerWindow:(NSWindow *)newWindow {
  if([self window]) {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidBecomeKeyNotification object:[self window]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSWindowDidResignKeyNotification object:[self window]];
  }
  if(newWindow) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_refreshActiveState) name:NSWindowDidBecomeKeyNotification object:newWindow];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_refreshActiveState) name:NSWindowDidResignKeyNotification object:newWindow];
  }
}

- (void)_refreshActiveState {
  self.isRenderedActive = [[self window] isKeyWindow];
}

# pragma mark Custom Properties
- (void)setIsRenderedActive:(BOOL)isRenderedActive {
  if(_isRenderedActive != isRenderedActive) {
    _isRenderedActive = isRenderedActive;
    [self setNeedsDisplay:YES];
  }
}

- (void)setBorderType:(HNHBorderType)borderType {
  if(_borderType != borderType) {
    _borderType = borderType;
    [self setNeedsDisplay:YES];
  }
}

- (void)setActiveGradient:(NSGradient *)activeGradient {
  if(_activeGradient != activeGradient) {
    _activeGradient = activeGradient;
    [self setNeedsDisplay:YES];
  }
}

- (void)setInactiveGradient:(NSGradient *)inactiveGradient {
  if(_inactiveGradient != inactiveGradient) {
    _inactiveGradient = inactiveGradient;
    [self setNeedsDisplay:YES];
  }
}

@end
