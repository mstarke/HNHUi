//
//  HNHRoundendTextFieldCellHelper.m
//
//  Created by Michael Starke on 30.06.13.
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

#import "HNHUITextFieldCellHelper.h"

#define CORNER_RADIUS 4.0
#define BUTTON_WIDTH 50.0
#define BUTTON_MARGIN 4.0

@implementation HNHUITextFieldCellHelper

void assignAttributesFromCell(NSTextFieldCell *destination, NSTextFieldCell *source) {
  destination.lineBreakMode = source.lineBreakMode;
  destination.truncatesLastVisibleLine = source.truncatesLastVisibleLine;
  destination.stringValue = source.stringValue;
  destination.attributedStringValue = source.attributedStringValue;
  destination.editable =source.isEditable;
  destination.placeholderString = source.placeholderString;
  destination.scrollable = source.isScrollable;
  destination.font = source.font;
  destination.bordered = source.isBordered;
  destination.bezeled = source.isBezeled;
  destination.backgroundStyle = source.backgroundStyle;
  destination.bezelStyle = source.bezelStyle;
  destination.drawsBackground = source.drawsBackground;
}

+ (NSButtonCell *)copyButtonCell {
  static NSButtonCell *cell = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    cell = [[NSButtonCell alloc] init];
    cell.bezelStyle = NSBezelStyleRegularSquare;
    [cell setButtonType:NSButtonTypeMomentaryPushIn];
    cell.controlSize = NSControlSizeSmall;
    cell.title = @"Copy";
    cell.bordered = YES;
  });
  return cell;
}

+ (void)drawCopyButtonWithFrame:(NSRect)cellFrame mouseDown:(BOOL)mouseDown controlView:(NSView *)view {
  NSCell *cell = [self copyButtonCell];
  
  CGFloat width = MIN( NSWidth(cellFrame) - BUTTON_MARGIN, cell.cellSize.width + BUTTON_MARGIN);
  NSRect buttonRect = NSMakeRect(NSMaxX(cellFrame) - width, NSMinY(cellFrame), width - BUTTON_MARGIN, NSHeight(cellFrame));

  cell.state = mouseDown ? NSControlStateValueOn : NSControlStateValueOff;
  cell.highlighted = mouseDown;
  [cell drawWithFrame:buttonRect inView:view];
}

@end
