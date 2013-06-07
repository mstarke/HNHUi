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

#define BUTTON_WIDTH 25

#import "HNHRoundedSecureTextFieldCell.h"

@interface HNHRoundedSecureTextFieldCell ()

/* ButtonCell used for Rendering and handling actions */
@property (nonatomic, retain) NSButtonCell *buttonCell;
@property (nonatomic, retain) NSSecureTextFieldCell *secureCell;

- (NSRect)_buttonCellForFrame:(NSRect)cellFrame;
- (NSRect)_textCellForFrame:(NSRect)cellFrame;
- (NSButtonCell *)_allocButtonCell;
- (NSSecureTextFieldCell *)_allocSecureCell;

@end

@implementation HNHRoundedSecureTextFieldCell

- (id)init {
  self = [super init];
  if(self) {
    _isObfuscated = YES;
    _buttonCell = [self _allocButtonCell];
    _secureCell = [self _allocSecureCell];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self ) {
    _isObfuscated = YES;
    _buttonCell = [self _allocButtonCell];
    _secureCell = [self _allocSecureCell];
  }
  return self;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
  [self.buttonCell setEnabled:[self isEnabled]];
  [self.buttonCell drawWithFrame:[self _buttonCellForFrame:cellFrame] inView:controlView];
  if(_isObfuscated) {
    [self.secureCell setTitle:[self title]];
    [self.secureCell drawInteriorWithFrame:[self _textCellForFrame:cellFrame] inView:controlView];
  }
  else {
    [super drawInteriorWithFrame:[self _textCellForFrame:cellFrame] inView:controlView];
  }
}

#pragma mark Helper
- (NSSecureTextFieldCell *)_allocSecureCell {
  NSSecureTextFieldCell *secureCell = [[NSSecureTextFieldCell alloc] init];
  [secureCell setFont:[self font]];
  [secureCell setAlignment:[self alignment]];
  [secureCell setControlSize:[self controlSize]];
  [secureCell setBezelStyle:[self bezelStyle]];
  [secureCell setBordered:[self isBordered]];
  [secureCell setBezeled:[self isBezeled]];
  return secureCell;
}

- (NSButtonCell *)_allocButtonCell {
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
