//
//  HNHUISecureTextView.m
//  HNHUi
//
//  Created by Michael Starke on 26.09.17.
//  Copyright © 2017 HicknHack Software GmbH. All rights reserved.
//

#import "HNHUISecureTextView.h"

@implementation HNHUISecureTextView

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
  if(menuItem.action == @selector(copy:)) {
    for(NSValue *rangeValue in self.selectedRanges) {
      if(rangeValue.rangeValue.length > 0) {
        return YES; 
      }
    }
  }
  return [super validateMenuItem:menuItem];
}

- (void)cut:(id)sender {
  if([self _shouldPerformAction:_cmd]) {
    [super cut:sender];
  }
}

- (void)paste:(id)sender {
  if([self _shouldPerformAction:_cmd]) {
    [super paste:sender];
  }
}

- (void)copy:(id)sender {
  if([self _shouldPerformAction:_cmd]) {
    [super copy:sender];
  }
}

- (NSMenu *)menuForEvent:(NSEvent *)event {
  if([self.delegate respondsToSelector:@selector(textView:menu:forEvent:atIndex:)]) {
    return [self.delegate textView:self menu:[super menuForEvent:event] forEvent:event atIndex:[self characterIndexForPoint:[NSEvent mouseLocation]]];
  }
  return [super menuForEvent:event];
}

- (BOOL)_shouldPerformAction:(SEL)action {
  if(self.delegate && [[self.delegate class] conformsToProtocol:@protocol(HNHUITextViewDelegate)]) {
    if([self.delegate respondsToSelector:@selector(textView:performAction:)]) {
      return [((id<HNHUITextViewDelegate>)self.delegate) textView:self performAction:action];
    }
  }
  return YES;
}

@end
