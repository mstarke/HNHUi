//
//  HNHGradientView.h
//
//  Created by Michael Starke on 20.02.13.
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

#import <AppKit/AppKit.h>


typedef NS_OPTIONS(NSUInteger, HNHBorderType) {
  HNHNoBorder     = 0,
  HNHBorderTop    = ( 1<<0 ),
  HNHBorderBottom = ( 1<<1 ),
  HNHBorderHighlight = (1<<2), // Only used with HNHBordrTop, otherwise ignored
  HNHBorderTopAndBottom = HNHBorderTop | HNHBorderBottom
};
/*
 A view just displaying a gradient
 */
@interface HNHGradientView : NSView

@property (nonatomic, assign) HNHBorderType borderType;
@property (nonatomic, strong) NSGradient *activeGradient;
@property (nonatomic, strong) NSGradient *inactiveGradient;

- (id)initWithFrame:(NSRect)frame activeGradient:(NSGradient *)activeGradient inactiveGradient:(NSGradient *)inactiveGradient;

@end
