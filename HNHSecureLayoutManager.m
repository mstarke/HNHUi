//
//  HNHSecureLayoutManager.m
//
//  Created by Michael Starke on 29.06.13.
//
//  Code take from: NSSecureLayoutManager.m
//  Copyright (c) 2006-2007 Christopher J. W. Lloyd
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Original - Christopher Lloyd <cjwl@objc.net>
//

#import "HNHSecureLayoutManager.h"
#import <AppKit/NSTextStorage.h>
#import <AppKit/NSAttributedString.h>

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@implementation HNHSecureLayoutManager

- (id)init {
  self = [super init];
  if(self) {
    _displayBullets = YES;
  }
  return self;
}

- (void)drawGlyphsForGlyphRange:(NSRange)glyphsToShow atPoint:(NSPoint)origin {
  [super drawGlyphsForGlyphRange:glyphsToShow atPoint:origin];
  return;
  /*
   FIXME: Layout get's broken
   */
  if(!_displayBullets) {
    [super drawGlyphsForGlyphRange:glyphsToShow atPoint:origin];
    return; // Done
  }
  NSLog(@"drawGlyphsForGlyphRange");
  NSFont *font = [[self textStorage] font];
  NSGlyph bullet = [font glyphWithName:@"bullet"];
  for(NSUInteger iIndex = 0; iIndex < glyphsToShow.length; iIndex++) {
    [self replaceGlyphAtIndex:(iIndex + glyphsToShow.location) withGlyph:bullet];
  }
  [super drawGlyphsForGlyphRange:glyphsToShow atPoint:origin];
}

@end
