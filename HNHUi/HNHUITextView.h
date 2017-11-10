//
//  HNHTextView.h
//  MacPass
//
//  Created by Michael Starke on 16/12/13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HNHUITextView;

@protocol HNHUITextViewDelegate <NSTextViewDelegate>
@optional
// called for an action that the textView wants to perform. Return NO if you want to prevent default behaviour
// if the TextView is a filed editor, this will get sent to the NSTextField which then calls out to it's delegate!
// See HNHUIRoundedTextField for details
- (BOOL)textView:(NSTextView *)textView performAction:(SEL)action;
@end

/**
 Custom TextView vented as field editor to enable customization of cut, copy and paste actions
 */
@interface HNHUITextView : NSTextView

@end
