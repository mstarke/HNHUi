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
- (BOOL)textView:(NSTextView *)textView performAction:(SEL)action;
@end

/**
 Custom TextView vented as field editor to enable customization of cut, copy and paste actions
 */
@interface HNHUITextView : NSTextView

@end
