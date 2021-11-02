//
//  HNHRoundedTextField.h
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

#import <AppKit/AppKit.h>
/**
 A Textfield with rounded apearance
 */
@protocol HNHUITextFieldDelegate <NSTextFieldDelegate>
@optional
// called for an action that the fieldEditor for this control want to perform. Return NO if you want to prevent default behaviour
- (BOOL)textField:(NSTextField *)textField textView:(NSTextView *)textView performAction:(SEL)action;
// called whenever a menu on the fieldeditor is opened to allow for customization of the menu via the delegate
- (NSMenu *)textField:(NSTextField *)textField textView:(NSTextView *)view menu:(NSMenu *)menu;
// called whenever the services menu should be displayed for a textfield.
- (BOOL)textField:(NSTextField *)textField allowServicesForTextView:(NSTextView *)textView;
@end

@interface HNHUITextField : NSTextField

@property (nonatomic, readonly, getter=isMouseOver) BOOL mouseOver;
@property (nonatomic, readonly, getter=isMouseDown) BOOL mouseDown;
@property (copy) NSString *buttonTitle;
@property (nonatomic, copy) void (^buttonActionBlock)(NSTextField *);

@end
