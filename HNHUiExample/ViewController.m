//
//  ViewController.m
//  HNHUiExample
//
//  Created by Michael Starke on 19.09.17.
//  Copyright © 2017 HicknHack Software GmbH. All rights reserved.
//

#import "ViewController.h"
#import "HNHUISecureTextField.h"

@interface ViewController ()
@property (weak) IBOutlet HNHUITextField *roundedTextField;
@property (weak) IBOutlet HNHUISecureTextField *roundedSecureTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.roundedTextField.buttonTitle = @"Do something!";
  self.roundedTextField.buttonActionBlock = ^(NSTextField *tf) {
    NSLog(@"Action!");
  };
  self.roundedSecureTextField.buttonTitle = @"Do something MORE!";
  self.roundedSecureTextField.buttonActionBlock = ^(NSTextField *tf) {
    NSLog(@"Action!");
  };

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

- (BOOL)textField:(NSTextField *)textField allowServicesForTextView:(NSTextView *)textView {
  return YES;
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

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(nullable id)item {
  return item ? 0 : 10;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(nullable id)item {
  if(item) {
    return @"Child";
  }
  return @"Group";
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
  return NO;
}

@end
