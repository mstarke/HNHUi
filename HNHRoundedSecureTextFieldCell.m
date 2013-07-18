//
//  HNHRoundedSecureTextFieldCell.m
//
//  Created by Michael Starke on 07.06.13.
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

#import "HNHRoundedSecureTextFieldCell.h"
#import "HNHRoundendTextFieldCellHelper.h"

#import <AppKit/NSTextFieldCell.h>

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#define BUTTON_WIDTH 25

@interface HNHRoundedSecureTextFieldCell () {
  NSButtonCell *_buttonCell;
}

/* ButtonCell used for Rendering and handling actions */
@property (nonatomic, strong) NSButtonCell *buttonCell;

- (NSRect)_buttonCellForFrame:(NSRect)cellFrame;
- (NSRect)_textCellForFrame:(NSRect)cellFrame;
- (NSButtonCell *)_allocButtonCell;

@end

@implementation HNHRoundedSecureTextFieldCell

- (id)init {
  self = [super init];
  if(self) {
    _drawHighlight = NO;
    _buttonCell = [self _allocButtonCell];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    if([aDecoder isKindOfClass:[NSKeyedUnarchiver class]]) {
      _buttonCell = [aDecoder decodeObjectForKey:@"buttonCell"];
    }
    if(!_buttonCell) {
      _buttonCell = [self _allocButtonCell];
    }
    _drawHighlight = NO;
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  if([aCoder isKindOfClass:[NSKeyedUnarchiver class]]) {
    [aCoder encodeObject:_buttonCell forKey:@"buttonCell"];
  }
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
  [HNHRoundendTextFieldCellHelper drawWithFrame:cellFrame enabled:[self isEnabled] withHighlight:_drawHighlight];
  [self drawInteriorWithFrame:cellFrame inView:controlView];
}

//- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
//  if([controlView respondsToSelector:@selector(currentEditor)]) {
//    if(![(id)controlView currentEditor]) {
//      [self.buttonCell setEnabled:[self isEnabled]];
//      [self.buttonCell drawWithFrame:[self _buttonCellForFrame:cellFrame] inView:controlView];
//    }
//  }
//  [super drawInteriorWithFrame:[self _textCellForFrame:cellFrame] inView:controlView];
//}

/* Set the focusRing to the bezel shape */
- (void)drawFocusRingMaskWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
  [[HNHRoundendTextFieldCellHelper bezelpathForRect:cellFrame withHightlight:_drawHighlight] fill];
}

/* We need to pass NO otherwise the roundend corners get rendering artifacts */
- (BOOL)drawsBackground {
  return NO;
}

#pragma mark -
#pragma mark TODO

//- (NSUInteger)hitTestForEvent:(NSEvent *)event inRect:(NSRect)cellFrame ofView:(NSView *)controlView {
//  NSPoint point = [controlView convertPoint:[event locationInWindow] fromView:nil];
//  NSRect textRect = [self _textCellForFrame:cellFrame];
//  NSRect buttonRect = [self _buttonCellForFrame:cellFrame];
//  if( NSMouseInRect(point, textRect, [controlView isFlipped])) {
//    return  NSCellHitContentArea | NSCellHitEditableTextArea;
//  }
//  if( NSMouseInRect(point, buttonRect, [controlView isFlipped])) {
//    return NSCellHitContentArea | NSCellHitTrackableArea;
//  }
//  return NSCellHitNone;
//}
//
//- (BOOL)startTrackingAt:(NSPoint)startPoint inView:(NSView *)controlView {
//  return [super startTrackingAt:startPoint inView:controlView];
//}


#pragma mark -
#pragma mark Helper
- (NSButtonCell *)_allocButtonCell NS_RETURNS_RETAINED {
  NSButtonCell *buttonCell = [[NSButtonCell alloc] init];
  [buttonCell setImage:[NSImage imageNamed:NSImageNameQuickLookTemplate ]];
  [buttonCell setTitle:@""];
  [buttonCell setAction:@selector(togglePassword)];
  [buttonCell setTarget:self];
  [buttonCell setBackgroundStyle:NSBackgroundStyleRaised];
  [buttonCell setBezeled:NO];
  [buttonCell setBordered:NO];
  [buttonCell setImagePosition:NSImageOnly];
  return buttonCell;
}

- (NSRect)_buttonCellForFrame:(NSRect)cellFrame {
  NSRect textFrame, buttonFrame;
  NSDivideRect(cellFrame, &buttonFrame, &textFrame, BUTTON_WIDTH, NSMaxXEdge);
  NSInsetRect(buttonFrame, 2, 2);
  return buttonFrame;
}

- (NSRect)_textCellForFrame:(NSRect)cellFrame {
  NSRect textFrame, buttonFrame;
  NSDivideRect(cellFrame, &buttonFrame, &textFrame, BUTTON_WIDTH, NSMaxXEdge);
  return textFrame;
}

@end
