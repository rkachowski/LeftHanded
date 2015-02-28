//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GridCell : CCNodeColor

@property (nonatomic) BOOL isSolid;

@property (nonatomic) CGPoint gridPosition;

@property(nonatomic, copy) NSString *type;

@property(nonatomic) BOOL debug;

- (void)setCellType:(NSString *)aChar;
@end