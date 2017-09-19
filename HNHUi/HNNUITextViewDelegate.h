//
//  HNHUITextFieldDelegate.h
//  HNHUi
//
//  Created by Michael Starke on 19.09.17.
//  Copyright © 2017 HicknHack Software GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HNHUITextView;

@protocol HNNUITextViewDelegate <NSObject>

@optional

- (BOOL)textView:(HNHUITextView *)textView performAction:(SEL)action;

@end
