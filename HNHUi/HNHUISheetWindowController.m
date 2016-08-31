//
//  HNHUISheetWindowController.m
//  HNHUi
//
//  Created by Michael Starke on 10.08.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "HNHUISheetWindowController.h"

@implementation HNHUISheetWindowController

- (id)initWithWindow:(NSWindow *)window {
  self = [super initWithWindow:window];
  if(self) {
    _isDirty = YES;
  }
  return self;
}

- (NSWindow *)window {
  NSWindow *window = super.window;
  [self updateView];
  return window;
}

- (void)updateView {
  // do nothing
}

- (void)dismissSheet:(NSInteger)returnCode {
  self.isDirty = YES;
  [super.window.sheetParent endSheet:super.window returnCode:returnCode];
}
@end
