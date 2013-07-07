//
//  HNHRoundedSecureTextField.h
//  MacPass
//
//  Created by Michael Starke on 07.07.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, HNHSecureTextFieldDisplayType) {
  HNHSecureTextFieldAlwaysHide, // Hide the Text all the time, act like a secure test field
  HNHSecureTextFieldClearTextWhileEdit, // Show the clear test only, if the editor is active
  HNHSecureTextFieldAlwaysShow // Display the Text all the time - act like a normal textfield
};

@interface HNHRoundedSecureTextField : NSSecureTextField

@property (nonatomic, assign) HNHSecureTextFieldDisplayType displayType;

@end
