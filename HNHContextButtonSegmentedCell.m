//
//  HNHContextButtonSegmentedCell.m
//  MacPass
//
//  Created by Michael Starke on 30.07.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "HNHContextButtonSegmentedCell.h"

@implementation HNHContextButtonSegmentedCell

- (BOOL)startTrackingAt:(NSPoint)startPoint inView:(NSView *)controlView {
//  NSInteger segment = [self selectedSegment];
//  if(segment == 1) {
//        NSEvent *event = [NSEvent mouseEventWithType:NSLeftMouseUp
//                                            location:startPoint
//                                       modifierFlags:0
//                                           timestamp:[NSDate timeIntervalSinceReferenceDate]
//                                        windowNumber:[[controlView window] windowNumber]
//                                             context:[[controlView window] graphicsContext]
//                                         eventNumber:0
//                                          clickCount:1
//                                            pressure:0];
//    [NSMenu popUpContextMenu:[self menuForSegment:1] withEvent:event forView:controlView];
//    return YES;
//  }
  return [super startTrackingAt:startPoint inView:controlView];
}
- (void)stopTracking:(NSPoint)lastPoint at:(NSPoint)stopPoint inView:(NSView *)controlView mouseIsUp:(BOOL)flag {
  [super stopTracking:lastPoint at:stopPoint inView:controlView mouseIsUp:flag];
}

@end
