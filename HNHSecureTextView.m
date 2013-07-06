//
//  HNHSecureTextView.m
//  MacPass
//
//  Created by Michael Starke on 29.06.13.
//
//  Code take from: NSSecureTextView.m
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

#import "HNHSecureTextView.h"
#import "HNHSecureLayoutManager.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@interface HNHSecureTextView () {
@private
  HNHSecureLayoutManager *_layoutManager;
}

@end

@implementation HNHSecureTextView

-initWithFrame:(NSRect)frame {
  self = [super initWithFrame:frame];
  if(self) {
    _secureInput = NO;
    _layoutManager = [[HNHSecureLayoutManager alloc] init];
    _layoutManager.displayBullets = NO;
    [[self textContainer] replaceLayoutManager:_layoutManager];
  }
  return self;
}

- (void)setSecureInput:(BOOL)secureInput {
  _layoutManager.displayBullets = secureInput;
}


-(BOOL)writeSelectionToPasteboard:(NSPasteboard *)pboard type:(NSString *)type {
  if(!_secureInput) {
    return [super writeSelectionToPasteboard:pboard type:type];
  }
  return NO;
}

-(BOOL)writeSelectionToPasteboard:(NSPasteboard *)pboard types:(NSArray *)types {
  if(!_secureInput) {
    return [super writeSelectionToPasteboard:pboard types:types];
  }
  return NO;
}

-(void)cut:sender {
  if(!_secureInput) {
    [super cut:sender];
  }
}

-(void)copy:sender {
  if(!_secureInput) {
    [super copy:sender];
  }
}

-(void)paste:sender {
  if(!_secureInput) {
    [super paste:sender];
  }
}

@end
