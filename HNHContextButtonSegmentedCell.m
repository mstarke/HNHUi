//
//  HNHContextButtonSegmentedCell.m
//  MacPass
//
//  Created by Michael Starke on 30.07.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "HNHContextButtonSegmentedCell.h"

@implementation HNHContextButtonSegmentedCell

- (SEL)action {
  NSView *control = [self controlView];
  [NSEvent mouseLocation];
  NSPoint location = [control convertPointFromBacking:[NSEvent mouseLocation]];
  NSLog(@"%@", NSStringFromPoint(location));
  //  if ([self tagForSegment:[self selectedSegment]] == -1) {
//    return nil;
//  }
//  else {
    return [super action];
  //}
}

@end
