//
//  HNHScrollDocumentViewAdapter.m
//
//  Created by Michael Starke on 16.06.13.
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

#import "HNHScrollDocumentViewAdapter.h"

@implementation HNHScrollDocumentViewAdapter

- (id)initWithFrame:(NSRect)frameRect {
  self = [super initWithFrame:frameRect];
  if(self) {
    _actFlipped = YES;
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    _actFlipped = YES;
    //[self setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return self;
}

- (BOOL)isFlipped {
  return _actFlipped;
}

- (void)setActFlipped:(BOOL)actFlipped {
  if(_actFlipped != actFlipped) {
    _actFlipped = actFlipped;
    [self setNeedsDisplay:YES];
  }
}

- (void)setDocumentView:(NSView *)documentView {
  if(_documentView != documentView) {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _documentView = documentView;
    //NSLog(@"%@",[_documentView constraints]);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_updateFrame:) name:NSViewFrameDidChangeNotification object:_documentView];
  }
}

- (void)_updateFrame:(NSNotification *)notification {
  //  NSView *subView = [notification object];
  //if(self == [subView superview]) {
  //NSLog(@"subframe: %@", NSStringFromRect([subView frame]));
    //NSRect myFrame = [self frame];
    //myFrame.size.height = MAX([subView frame].size.height, myFrame.size.height);
    //NSLog(@"myframe: %@", NSStringFromRect(myFrame));
    //[self setFrameSize:[subView frame].size];
    //}
}


@end