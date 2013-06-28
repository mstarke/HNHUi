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



#import "HNHScrollView.h"

#define GRADIENT_OUTER_COLOR  [NSColor colorWithCalibratedWhite:0.0 alpha:0]
#define GRADIENT_INNER_COLOR [NSColor colorWithCalibratedWhite:0.5 alpha:1]

@implementation HNHScrollView

- (void)reflectScrolledClipView:(NSClipView *)cView {
  [super reflectScrolledClipView:cView];

  
  NSRect documentRect = [[self documentView] frame];
  NSRect visibleRect = [self documentVisibleRect];
  BOOL oldTop = _topClipped;
  BOOL oldBottom = _bottomClipped;
  _topClipped = NSMinY(visibleRect) > 0;
  _bottomClipped = NSMaxY(documentRect) > NSMaxY(visibleRect);
  
  if(_topClipped != oldTop || _bottomClipped != oldBottom) {
    [self setNeedsDisplay:YES];
  }
}

- (void)drawRect:(NSRect)dirtyRect {
  NSGradient *gradient = [[NSGradient alloc] initWithColorsAndLocations:GRADIENT_OUTER_COLOR,
                          0.0,
                          GRADIENT_INNER_COLOR,
                          0.2,
                          GRADIENT_INNER_COLOR,
                          0.8,
                          GRADIENT_OUTER_COLOR,
                          1.0 , nil];
  
  if(_bottomClipped) {
    NSRect bottomLine = NSMakeRect(0, NSMaxY([self bounds]) - 1, NSWidth([self bounds]), 1);
    [gradient drawInRect:bottomLine angle:0];
  }
  if(_topClipped) {
    NSRect topLine = NSMakeRect(0, 0, NSWidth([self bounds]), 1);
    [gradient drawInRect:topLine angle:0];
  }
  [gradient release];
}

@end
