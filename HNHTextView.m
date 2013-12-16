//
//  HNHTextView.m
//  MacPass
//
//  Created by Michael Starke on 16/12/13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "HNHTextView.h"

@interface HNHTextView () {
  NSTrackingArea *_trackingArea;
  BOOL _isMouseOver;
  BOOL _isMouseDown;
}

@end

@implementation HNHTextView

- (void)drawRect:(NSRect)dirtyRect {
  [super drawRect:dirtyRect];
}

- (void)mouseEntered:(NSEvent *)theEvent {
  _isMouseOver = YES;
  //[self setNeedsDisplay];
}

- (void)mouseExited:(NSEvent *)theEvent {
  _isMouseOver = NO;
  _isMouseDown = NO;
  //[self setNeedsDisplay];
}

- (void)mouseDown:(NSEvent *)theEvent {
  _isMouseDown = YES;
  //[self setNeedsDisplay];
}

- (void)mouseUp:(NSEvent *)theEvent {
  _isMouseDown = NO;
  /*[self setNeedsDisplay];
  if(self.copyActionBlock) {
    self.copyActionBlock(self);
  }
   */
}

- (void)viewWillMoveToWindow:(NSWindow *)newWindow {
  if(_trackingArea) {
    [self removeTrackingArea:_trackingArea];
  }
}

- (void)viewDidMoveToWindow {
  [self _updateTrackingArea];
}

- (void)setFrame:(NSRect)frameRect {
  [super setFrame:frameRect];
  [self _updateTrackingArea];
}

- (void)_updateTrackingArea {
  if(_trackingArea) {
    [self removeTrackingArea:_trackingArea];
    _trackingArea = nil;
  }
  if(![self isEditable] && ![self isSelectable]) {
    _trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
                                                 options:NSTrackingMouseEnteredAndExited|NSTrackingInVisibleRect|NSTrackingActiveAlways
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:_trackingArea];
  }
}

@end
