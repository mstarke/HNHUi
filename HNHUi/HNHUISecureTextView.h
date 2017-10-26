//
//  HNHUISecureTextView.h
//  HNHUi
//
//  Created by Michael Starke on 26.09.17.
//  Copyright © 2017 HicknHack Software GmbH. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HNHUITextView.h"
/* declare NSSecureTextView to silence compiler warnings */
@interface NSSecureTextView : NSTextView
@end

@interface HNHUISecureTextView : NSSecureTextView

@end
