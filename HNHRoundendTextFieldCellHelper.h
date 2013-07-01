//
//  HNHRoundendTextFieldCellHelper.h
//  MacPass
//
//  Created by Michael Starke on 30.06.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import <Foundation/NSObject.h>
#import <AppKit/NSBezierPath.h>

@interface HNHRoundendTextFieldCellHelper : NSObject

+ (void)drawWithFrame:(NSRect)cellFrame enabled:(BOOL)isEnabled withHighlight:(BOOL)highlight;
+ (NSBezierPath *)bezelpathForRect:(NSRect)aRect withHightlight:(BOOL)highlight;

@end
