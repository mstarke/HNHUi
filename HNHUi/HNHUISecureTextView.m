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
  BOOL valid = [super validateMenuItem:menuItem];
  if(menuItem.action == @selector(copy:)) {
    valid = YES;
  }
  return valid;
}

- (void)copy:(id)sender {
  [super copy:sender];
}

@end
