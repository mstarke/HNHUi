//
//  HNHShadowBox.m
//
//  Created by Michael Starke on 11.06.13.
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
#import "HNHShadowBox.h"

NSString *const kHNHBackgroundGradientArchiveKey = @"backgroundGradient";
NSString *const KHNHBackgroundShadowArchiveKey = @"backgroundShadow";

@interface HNHShadowBox () {
  NSGradient *_backgroundGradient;
  NSShadow *_boxShadow;
}
@end

@implementation HNHShadowBox

- (id)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];
  if(self) {
    [self _setupGradients];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  _backgroundGradient = [aDecoder decodeObjectForKey:kHNHBackgroundGradientArchiveKey];
  _boxShadow = [aDecoder decodeObjectForKey:KHNHBackgroundShadowArchiveKey];
  if(!_boxShadow || !_backgroundGradient) {
    /* Release possible valid encodings */
    [_boxShadow release];
    [_backgroundGradient release];
    [self _setupGradients];
  }
  return self;
}

- (void)dealloc {
  [_backgroundGradient release];
  [_boxShadow release];
  [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:_backgroundGradient forKey:kHNHBackgroundGradientArchiveKey];
  [aCoder encodeObject:_boxShadow forKey:KHNHBackgroundShadowArchiveKey];
}

- (NSBoxType)boxType {
  return NSBoxCustom;
}

- (void)drawRect:(NSRect)dirtyRect {
  [NSGraphicsContext saveGraphicsState];
  [_boxShadow set];
  NSRect drawRect = NSInsetRect([self bounds], [_boxShadow shadowBlurRadius], [_boxShadow shadowBlurRadius]);
  drawRect.origin.y += 1;
  [[self fillColor] setFill];
  [[self _strokePathForRect:drawRect] fill];
  //[_backgroundGradient drawInBezierPath:[self _fillPathForRect:drawRect] angle:90];
  [NSGraphicsContext restoreGraphicsState];
  if( [self borderWidth] > 0 ) {
    NSBezierPath *path = [self _strokePathForRect:drawRect];
    [[self borderColor] setFill];
    [path setLineWidth:[self borderWidth]];
    [[self borderColor] setStroke];
    [path stroke];
  }
}

#pragma mark Helper
- (void)_setupGradients {
  _backgroundGradient = [[NSGradient alloc] initWithColors:@[[NSColor colorWithCalibratedWhite:0.95 alpha:1], [NSColor whiteColor]]];
  _boxShadow = [[NSShadow alloc] init];
  [_boxShadow setShadowBlurRadius:1];
  [_boxShadow setShadowOffset:NSMakeSize(0, -1)];
  [_boxShadow setShadowColor:[NSColor colorWithCalibratedWhite:0.7 alpha:1]];
}

- (NSBezierPath *)_fillPathForRect:(NSRect)rect {

  return [NSBezierPath bezierPathWithRoundedRect:rect xRadius:[self cornerRadius] yRadius:[self cornerRadius]];
}

- (NSBezierPath *)_strokePathForRect:(NSRect)rect {
  NSRect insetRect = NSInsetRect(rect,[self borderWidth]/2, [self borderWidth]/2);
  return [NSBezierPath bezierPathWithRoundedRect:insetRect xRadius:[self cornerRadius] yRadius:[self cornerRadius]];
}
@end
