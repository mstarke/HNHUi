//
//  HNHRoundedTextField.m
//
//  Created by Michael Starke on 11.06.13.
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

#import "HNHUIRoundedTextField.h"
#import "HNHUIRoundedTextFieldCell.h"
#import "HNHUITextView.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@interface HNHUIRoundedTextField () <HNHUITextViewDelegate>

@property (strong, nullable) NSTrackingArea *trackingArea;
@property (nonatomic) BOOL mouseOver;
@property (nonatomic) BOOL mouseDown;
@property (nonatomic, readonly) BOOL requiresTrackingArea;

@end

@implementation HNHUIRoundedTextField

+ (Class)cellClass {
  return [HNHUIRoundedTextFieldCell class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    _mouseDown = NO;
    _mouseOver = NO;
    /* make sure we have the correct cell within, if not, swap it but keep all the attribues */
    if(![self.cell isMemberOfClass:[HNHUIRoundedTextFieldCell class]]) {
      NSMutableData *data = [[NSMutableData alloc] init];
      NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
      [self.cell encodeWithCoder:archiver];
      [archiver finishEncoding];
      
      NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
      HNHUIRoundedTextFieldCell *cell = [[HNHUIRoundedTextFieldCell alloc] initWithCoder:unarchiver];
      [unarchiver finishDecoding];
      
      self.cell = cell;
      self.needsDisplay = YES;
    }
  }
  return self;
}
/* vent HNHUITextView delegation to HNHUITextFieldDelegate */
- (BOOL)textView:(NSTextView *)textView performAction:(SEL)action {
  if([[self.delegate class] conformsToProtocol:@protocol(HNHUITextFieldDelegate)]) {
    if([self.delegate respondsToSelector:@selector(textField:textView:performAction:)]) {
      return [((id<HNHUITextFieldDelegate>)self.delegate) textField:self textView:textView performAction:action];
    }
  }
  return YES;
}

#pragma mark properties
- (void)setEditable:(BOOL)flag {
  super.editable = flag;
  [self _updateTrackingArea];
}

- (void)setMouseDown:(BOOL)mouseDown {
  if(_mouseDown != mouseDown) {
    _mouseDown = mouseDown;
    self.needsDisplay = YES;
  }
}

- (void)setMouseOver:(BOOL)mouseOver {
  if(_mouseOver != mouseOver) {
    _mouseOver = mouseOver;
    self.needsDisplay = YES;
  }
}

- (void)setCopyActionBlock:(void (^)(NSTextField *))copyActionBlock {
  _copyActionBlock = [copyActionBlock copy];
  [self _updateTrackingArea];
}

- (BOOL)requiresTrackingArea {
  /* We only need to track if we got an action or are not editable */
  return !self.isEditable && self.copyActionBlock;
}

#pragma mark mouse events

- (void)mouseEntered:(NSEvent *)theEvent {
  self.mouseOver = YES;
}

- (void)mouseExited:(NSEvent *)theEvent {
  self.mouseDown = NO;
  self.mouseOver = NO;
}

- (void)mouseDown:(NSEvent *)theEvent {
  self.mouseDown = YES;
}

- (void)mouseUp:(NSEvent *)theEvent {
  self.mouseDown = NO;
  if(self.copyActionBlock) {
    self.copyActionBlock(self);
  }
}

- (void)viewWillMoveToWindow:(NSWindow *)newWindow {
  if(self.trackingArea) {
    [self removeTrackingArea:self.trackingArea];
  }
}

- (void)viewDidMoveToWindow {
  [self _updateTrackingArea];
}

- (void)setFrame:(NSRect)frameRect {
  super.frame = frameRect;
  [self _updateTrackingArea];
}

- (NSMenu *)textView:(NSTextView *)view menu:(NSMenu *)menu forEvent:(NSEvent *)event atIndex:(NSUInteger)charIndex {
  if([self.delegate respondsToSelector:@selector(textField:textView:menu:)]) {
    return [((id<HNHUITextFieldDelegate>)self.delegate) textField:self textView:view menu:menu];
  }
  return menu;
}


/* TODO: move over to updateTrackingAreas? */
- (void)_updateTrackingArea {
  if(self.trackingArea) {
    [self removeTrackingArea:self.trackingArea];
    self.trackingArea = nil;
  }
  if(self.requiresTrackingArea) {
    self.trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
                                                 options:NSTrackingMouseEnteredAndExited|NSTrackingInVisibleRect|NSTrackingActiveAlways
                                                   owner:self
                                                userInfo:nil];
    [self addTrackingArea:self.trackingArea];
  }
}

@end
