//
//  HNHRoundedSecureTextField.h
//  MacPass
//
//  Created by Michael Starke on 07.07.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface HNHRoundedSecureTextField : NSSecureTextField <NSTextFieldDelegate>

@property (nonatomic, assign) BOOL showPassword;

- (IBAction) toggleDisplay:(id)sender;

@end
