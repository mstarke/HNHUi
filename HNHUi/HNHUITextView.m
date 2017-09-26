//
//  HNHTextView.m
//  MacPass
//
//  Created by Michael Starke on 16/12/13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "HNHUITextView.h"
#import "HNHUIRoundedTextField.h"

@interface HNHUITextView ()
/*
 {
 NSTrackingArea *_trackingArea;
 BOOL _isMouseOver;
 BOOL _isMouseDown;
 }
 */

@end

@implementation HNHUITextView

/*
 - (void)drawRect:(NSRect)dirtyRect {
 [super drawRect:dirtyRect];
 }
 
 - (void)mouseEntered:(NSEvent *)theEvent {
 _isMouseOver = YES;
 }
 
 - (void)mouseExited:(NSEvent *)theEvent {
 _isMouseOver = NO;
 _isMouseDown = NO;
 }
 
 - (void)mouseDown:(NSEvent *)theEvent {
 _isMouseDown = YES;
 }
 
 - (void)mouseUp:(NSEvent *)theEvent {
 _isMouseDown = NO;
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
 super.frame = frameRect;
 [self _updateTrackingArea];
 }
 
 - (void)_updateTrackingArea {
 if(_trackingArea) {
 [self removeTrackingArea:_trackingArea];
 _trackingArea = nil;
 }
 if(!self.editable && !self.selectable) {
 _trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
 options:NSTrackingMouseEnteredAndExited|NSTrackingInVisibleRect|NSTrackingActiveAlways
 owner:self
 userInfo:nil];
 [self addTrackingArea:_trackingArea];
 }
 }
 */

- (void)cut:(id)sender {
  if([self _shouldPerformAction:_cmd]) {
    [super cut:sender];
  }
}

- (void)paste:(id)sender {
  if([self _shouldPerformAction:_cmd]) {
    [super paste:sender];
  }
}

- (void)copy:(id)sender {
  if([self _shouldPerformAction:_cmd]) {
    [super copy:sender];
  }
}

- (BOOL)_shouldPerformAction:(SEL)action {
  if(self.delegate && [[self.delegate class] conformsToProtocol:@protocol(HNHUITextViewDelegate)]) {
    if([self.delegate respondsToSelector:@selector(textView:performAction:)]) {
      return [((id<HNHUITextViewDelegate>)self.delegate) textView:self performAction:action];
    }
  }
  return YES;
}


@end
