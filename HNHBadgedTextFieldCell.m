//
//  HNHBadgedTextFieldCell.m
//
//  Created by Michael Starke on 08.06.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//
//  This Code uses the badge drawing from PXSourceList.m
//  Please refer to LICENSE_PXSourceList for the Licensing
//
//  Created by Alex Rozanski on 05/09/2009.
//  Copyright 2009-10 Alex Rozanski http://perspx.com
//
//  GC-enabled code revised by Stefan Vogt http://byteproject.net
//

#import "HNHBadgedTextFieldCell.h"
#import "HNHBadgedTextField.h"

#define BADGE_HEIGHT 16
#define BADGE_BACKGROUND_COLOR [NSColor colorWithRed:0.592 green:0.651 blue:0.710 alpha:1.0]
#define BADGE_HIDDEN_BACKGROUND_COLOR [NSColor lightGrayColor]
#define BADGE_SELECTED_BACKGROUND_COLOR [NSColor whiteColor]
#define BADGE_FONT [NSFont boldSystemFontOfSize:11]
#define MIN_BADGE_WIDTH 20
#define BADGE_MARGIN 4
#define ROW_RIGHT_MARGIN 0

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@interface HNHBadgedTextFieldCell () {
  NSShadow *_badgeShadow;
}

- (void)_drawBadgeWithCount:(NSInteger)count inFrame:(NSRect)badgeFrame;
- (NSSize)_sizeOfBadgeForCount:(NSInteger)count;

@end

@implementation HNHBadgedTextFieldCell

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    _badgeShadow = [[NSShadow alloc] init];
    [_badgeShadow setShadowColor:[NSColor whiteColor]];
    [_badgeShadow setShadowOffset:NSMakeSize(0, -1)];
    [_badgeShadow setShadowBlurRadius:0];
  }
  return self;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
  NSUInteger count = NSNotFound;
  BOOL showEmpty = YES;
  
  if([controlView respondsToSelector:@selector(count)]) {
    count = [(id)controlView count];
  }
  if([controlView respondsToSelector:@selector(showEmptyBadge)]) {
    showEmpty = [(id)controlView showEmptyBadge];
  }
  if( (count != 0 && count != NSNotFound) || (showEmpty && count == 0)) {
    NSSize badgeSize = [self _sizeOfBadgeForCount:count];
    NSRect badgeFrame = NSMakeRect(NSMaxX(cellFrame) - badgeSize.width - ROW_RIGHT_MARGIN,
                                   NSMidY(cellFrame) - floor(badgeSize.height/2.0),
                                   badgeSize.width + _badgeShadow.shadowOffset.width,
                                   badgeSize.height + _badgeShadow.shadowOffset.height);
    
    [self _drawBadgeWithCount:count inFrame:badgeFrame];
    NSRect clippedInterior = NSMakeRect(NSMinX(cellFrame), NSMinY(cellFrame), NSWidth(cellFrame) - NSWidth(badgeFrame), NSHeight(cellFrame));
    [self drawInteriorWithFrame:clippedInterior inView:controlView];
  }
  else {
    [self drawInteriorWithFrame:cellFrame inView:controlView];
  }
}

- (void)_drawBadgeWithCount:(NSInteger)count inFrame:(NSRect)badgeFrame;
{
	NSBezierPath *badgePath = [NSBezierPath bezierPathWithRoundedRect:badgeFrame
                                                            xRadius:(BADGE_HEIGHT/2.0)
                                                            yRadius:(BADGE_HEIGHT/2.0)];
  
	//Get window and control state to determine colours used
	BOOL isVisible = [[NSApp mainWindow] isVisible];
  BOOL isSelected = ([self backgroundStyle] != NSBackgroundStyleLight && [self backgroundStyle] != NSBackgroundStyleLowered);
	//Set the attributes based on the row state
  
	NSColor *backgroundColor;
  //Set the text colour based on window and control state
  NSColor *badgeColor = isSelected ? [NSColor colorWithRed:0.592 green:0.651 blue:0.710 alpha:1.0] : [NSColor whiteColor];
  
  if(isVisible) {
    backgroundColor = isSelected ? BADGE_SELECTED_BACKGROUND_COLOR : BADGE_BACKGROUND_COLOR;
  }
  else { //Gray colour
    backgroundColor = isSelected ? BADGE_SELECTED_BACKGROUND_COLOR : BADGE_HIDDEN_BACKGROUND_COLOR;
  }
 	NSDictionary *attributes = @{ NSFontAttributeName: BADGE_FONT, NSForegroundColorAttributeName : badgeColor };
  
  if(isSelected) {
    [NSGraphicsContext saveGraphicsState]; // Only save/restore if needed
    [_badgeShadow set];
  }
  [backgroundColor set];
	[badgePath fill];
  if(isSelected) {
    [NSGraphicsContext restoreGraphicsState];
  }
	//Draw the badge text
	NSAttributedString *badgeAttrString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", (long)count]
                                                                        attributes:attributes];
	NSSize stringSize = [badgeAttrString size];
	NSPoint badgeTextPoint = NSMakePoint(NSMidX(badgeFrame)-(stringSize.width/2.0),		//Center in the badge frame
                                       NSMidY(badgeFrame)-(stringSize.height/2.0));	//Center in the badge frame
	[badgeAttrString drawAtPoint:badgeTextPoint];
}

- (NSSize)_sizeOfBadgeForCount:(NSInteger)count
{
	NSAttributedString *badgeAttrString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", (long)count]
                                                                        attributes:@{NSFontAttributeName: BADGE_FONT}];
  
	NSSize stringSize = [badgeAttrString size];
  
	//Calculate the width needed to display the text or the minimum width if it's smaller
	CGFloat width = stringSize.width+(2*BADGE_MARGIN);
  
	if(width<MIN_BADGE_WIDTH) {
		width = MIN_BADGE_WIDTH;
	}
    
	return NSMakeSize(width, BADGE_HEIGHT);
}

@end
