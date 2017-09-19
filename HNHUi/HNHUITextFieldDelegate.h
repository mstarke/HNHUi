//
//  HNHUITextFieldDelegate.h
//  HNHUi
//
//  Created by Michael Starke on 19.09.17.
//  Copyright © 2017 HicknHack Software GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol HNHUITextFieldDelegate <NSObject>

@optional
- (BOOL)textField:(NSTextField *)textField performAction:(SEL)action;
@end
