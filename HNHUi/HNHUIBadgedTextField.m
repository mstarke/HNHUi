//
//  HNHBadgedTableCellView.m
//
//  Created by Michael Starke on 08.06.13.
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

#import "HNHUIBadgedTextField.h"
#import "HNHUIBadgedTextFieldCell.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@implementation HNHUIBadgedTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    /* make sure we have the correct cell within, if not, swap it but keep all the attribues */
    if(![self.cell isMemberOfClass:HNHUIBadgedTextFieldCell.class]) {
      NSMutableData *data = [[NSMutableData alloc] init];
      NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
      [self.cell encodeWithCoder:archiver];
      [archiver finishEncoding];
      
      NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
      HNHUIBadgedTextFieldCell *cell = [[HNHUIBadgedTextFieldCell alloc] initWithCoder:unarchiver];
      [unarchiver finishDecoding];
      
      self.cell = cell;
      self.needsDisplay = YES;
    }
    _count = NSNotFound;
    _showEmptyBadge = NO;
  }
  return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];
  if(self) {
    _count = NSNotFound;
    _showEmptyBadge = NO;
  }
  return self;
}

- (BOOL)wantsUpdateLayer {
  return NO;
}

- (void)setCount:(NSInteger)count {
  if(_count != count) {
    _count = count;
    self.needsDisplay = YES;
  }
}

- (void)setShowEmptyBadge:(BOOL)showEmptyBadge {
  if(_showEmptyBadge != showEmptyBadge) {
    _showEmptyBadge = showEmptyBadge;
    self.needsDisplay = YES;
  }
}

@end
