//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class GridCell;


@interface Grid : CCSprite
{
    CGSize _cellSize;
}


@property(nonatomic) CGSize cellSize;
@property(nonatomic, strong) NSMutableArray *cells;
@property(nonatomic) BOOL drawing;
@property(nonatomic, strong) NSMutableSet *drawnSet;

- (void)setCellsFromArray:(NSArray *)array;

- (GridCell *)cellAtPoint:(CGPoint)point;

- (void)printGrid;

- (void)setCell:(GridCell *)cell toType:(NSString *)type;
@end