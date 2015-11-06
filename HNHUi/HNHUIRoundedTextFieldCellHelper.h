//
//  HNHRoundendTextFieldCellHelper.h
//
//  Created by Michael Starke on 30.06.13.
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
 *	Helper that can be called by Textfields, that need the same apearance.
 *  It's used by HNHRoundedTextFieldCell and HNHRoundedSecureTextFieldCell
 */
@interface HNHUIRoundedTextFieldCellHelper : NSObject

+ (void)drawWithFrame:(NSRect)cellFrame enabled:(BOOL)isEnabled withHighlight:(BOOL)highlight;

+ (NSBezierPath *)bezelpathForRect:(NSRect)aRect withHightlight:(BOOL)highlight;
/**
 *	Draws the Copy button on a hovering Field
 *	@param	cellFrame	Frame to draw the button in
 *	@param	mouseDown	Flag to indicate if the mouse is pressed or not
 *	@param	view	view that is drawing the button
 */
+ (void)drawCopyButtonWithFrame:(NSRect)cellFrame mouseDown:(BOOL)mouseDown controlView:(NSView *)view;

@end
