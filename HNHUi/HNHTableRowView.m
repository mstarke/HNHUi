//
//  HNHTableRowView.m
//
//  Created by Michael Starke on 17.06.13.
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

#import "HNHTableRowView.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#define DEFAULT_SELECTION_RADIUS 5.0

@implementation HNHTableRowView

- (void)awakeFromNib {
  _selectionCornerRadius = DEFAULT_SELECTION_RADIUS;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];
  if(self) {
    _selectionCornerRadius = DEFAULT_SELECTION_RADIUS;
  }
  return self;
}

- (void)setSelectionCornerRadius:(CGFloat)selectionCornerRadius {
  if(_selectionCornerRadius != selectionCornerRadius) {
    _selectionCornerRadius = selectionCornerRadius;
    /* TODO: Optimize by just setting the dirty corners */
    self.needsDisplay = YES;
  }
}

- (void)drawSelectionInRect:(NSRect)dirtyRect {
  NSBezierPath *clip = [NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:_selectionCornerRadius yRadius:_selectionCornerRadius];
  [clip addClip];
  [super drawSelectionInRect:dirtyRect];
}

@end
