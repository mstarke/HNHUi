//
//  NSButton+HNHTextColor.m
//
//  Created by Michael Starke on 29.01.14.
//  Copyright (c) 2014 HicknHack Software GmbH. All rights reserved.
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
//  Derived from Apple Sample Code:
//  https://developer.apple.com/library/mac/samplecode/Popover/Listings/NSButton_Extended_m.html

#import "NSButton+HNHUITextColor.h"

@implementation NSButton (HNHUITextColor)

- (NSColor *)textColor {
  NSUInteger titleLength = self.attributedTitle.length;
  NSRange range = NSMakeRange(0, MIN(titleLength, 1));
  NSDictionary *attributes = [self.attributedTitle fontAttributesInRange:range];
  if (attributes) {
    return attributes[NSForegroundColorAttributeName];
  }
  return [NSColor controlTextColor];
}

- (void)setTextColor:(NSColor *)textColor {
  NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedTitle];
  NSUInteger titleLength = attributedTitle.length;
  NSRange range = NSMakeRange(0, titleLength);
  [attributedTitle addAttribute:NSForegroundColorAttributeName value:textColor range:range];
  [attributedTitle fixAttributesInRange:range];
  self.attributedTitle = attributedTitle;
}

@end
