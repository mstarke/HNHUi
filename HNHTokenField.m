//
//  HNHTokenField.m
//  MacPass
//
//  Created by Michael Starke on 18.07.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import "HNHTokenField.h"
#import "HNHTokenFieldCell.h"

@implementation HNHTokenField

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if(self) {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [[self cell] encodeWithCoder:archiver];
    [archiver finishEncoding];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    HNHTokenFieldCell *newCell = [[HNHTokenFieldCell alloc] initWithCoder:unarchiver];
    [unarchiver finishDecoding];
    
    [self setCell:newCell];
  }
  return self;
}

@end
