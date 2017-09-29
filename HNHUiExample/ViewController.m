//
//  ViewController.m
//  HNHUiExample
//
//  Created by Michael Starke on 19.09.17.
//  Copyright © 2017 HicknHack Software GmbH. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Do any additional setup after loading the view.
}

- (NSMenu *)textField:(NSTextField *)textField textView:(NSTextView *)view menu:(NSMenu *)menu {
  for(NSMenuItem *item in menu.itemArray) {
    if(item.action == @selector(cut:) ||
       item.action == @selector(paste:) ||
       item.action == @selector(copy:) ||
       item.action == @selector(selectAll:)) {
      continue;
    }
    [menu removeItem:item];
  }
  return menu;
}

- (BOOL)textField:(NSTextField *)textField textView:(NSTextView *)textView performAction:(SEL)action {
  NSLog(@"%@ %@", NSStringFromSelector(_cmd), NSStringFromSelector(action));
  return YES;
}

- (BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
  NSLog(@"%@ %@", NSStringFromSelector(_cmd), NSStringFromSelector(commandSelector));
  return YES;
}

- (void)doCommandBySelector:(SEL)selector {
  NSLog(@"%@ %@", NSStringFromSelector(_cmd), NSStringFromSelector(selector));
  [super doCommandBySelector:selector];
}

@end
