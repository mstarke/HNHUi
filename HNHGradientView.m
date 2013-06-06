//
//  HNHGradientView.m
//  Created by Michael Starke on 20.02.13.
//
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

@interface HNHGradientView ()

@property (assign, nonatomic) BOOL isRenderedActive;
@property (retain) NSGradient *activeGradient;
@property (retain) NSGradient *inactiveGradient;

- (void)_refreshActiveState;

@end

@implementation HNHGradientView

- (id)initWithFrame:(NSRect)frameRect {
  NSColor *activeTop = [NSColor colorWithCalibratedWhite:0.85 alpha:1];
  NSColor *activeBottom = [NSColor colorWithCalibratedWhite:0.7 alpha:1];
  NSColor *inactiveTop = [NSColor colorWithCalibratedWhite:0.9 alpha:1];
  NSColor *inactiveBottom = [NSColor colorWithCalibratedWhite:0.85 alpha:1];
  NSGradient *activeGradient = [[[NSGradient alloc] initWithColors:@[ activeBottom, activeTop ]] autorelease];
  NSGradient *inactiveGradient = [[[NSGradient alloc] initWithColors:@[ inactiveBottom, inactiveTop ]] autorelease];
  return [self initWithFrame:frameRect activeGradient:activeGradient inactiveGradient:inactiveGradient];
}

- (id)initWithFrame:(NSRect)frame activeGradient:(NSGradient *)activeGradient inactiveGradient:(NSGradient *)inactiveGradient {
  self = [super initWithFrame:frame];
  if(self) {
    _activeGradient = [activeGradient retain];
    _inactiveGradient = [inactiveGradient retain];
  }
  return self;
}

- (void)dealloc {
  self.activeGradient = nil;
  self.inactiveGradient = nil;
  [super dealloc];
}

#pragma mark Drawing

- (void)drawRect:(NSRect)dirtyRect {
  /*
   We draw a Gradient, so make sure we always redraw the full view
   */
  NSGradient *gradient = self.isRenderedActive ? self.activeGradient : self.inactiveGradient;
  [gradient drawInRect:self.bounds angle:90];
}

- (BOOL)isOpaque {
  return YES;
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

- (void)viewWillMoveToWindow:(NSWindow *)newWindow {
  [self _registerWindow:newWindow];
  [super viewWillMoveToWindow:newWindow];
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

@end
