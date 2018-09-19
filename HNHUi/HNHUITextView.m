//
//  HNHTextView.m
//  MacPass
//
//  Created by Michael Starke on 16/12/13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "HNHUITextView.h"
#import "HNHUITextField.h"

@implementation HNHUITextView

- (id)validRequestorForSendType:(NSPasteboardType)sendType returnType:(NSPasteboardType)returnType {
  if(self.delegate && [[self.delegate class] conformsToProtocol:@protocol(HNHUITextViewDelegate)]) {
    if([self.delegate respondsToSelector:@selector(allowServicesForTextView:)]) {
      if(![((id<HNHUITextViewDelegate>)self.delegate) allowServicesForTextView:self]) {
        return nil;
      }
    }
  }
  return [super validRequestorForSendType:sendType returnType:returnType];
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

- (BOOL)_shouldPerformAction:(SEL)action {
  if(self.delegate && [[self.delegate class] conformsToProtocol:@protocol(HNHUITextViewDelegate)]) {
    if([self.delegate respondsToSelector:@selector(textView:performAction:)]) {
      return [((id<HNHUITextViewDelegate>)self.delegate) textView:self performAction:action];
    }
  }
  return YES;
}


@end
