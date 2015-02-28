//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "Grid.h"
#import "GridCell.h"

static const CGSize GRID_SIZE = {.height = 12, .width = 24};
static const int SPACING = 20;

@implementation Grid
{
    NSMutableArray *_cells;
}


@synthesize cellSize;

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    [self calculateGridSize];
    [self createCells];
}

- (void)createCells
{
    _cells = [NSMutableArray arrayWithCapacity:(NSUInteger) GRID_SIZE.width];

    for (int x = 0; x < GRID_SIZE.width; x++)
    {
        _cells[x] = [NSMutableArray arrayWithCapacity:(NSUInteger) GRID_SIZE.height];

        for (int y = 0; y < GRID_SIZE.height; y++)
        {
            CGPoint position = ccp(x * _cellSize.width + SPACING, y * _cellSize.height + SPACING);

            GridCell *cell = [[GridCell alloc] initWithColor:[CCColor redColor] width:_cellSize.width height:_cellSize.height];
            cell.position = position;

            _cells[x][y] = cell;
            [self addChild:cell];
        }
    }
}

- (void)calculateGridSize
{
    CGSize viewSize = [CCDirector sharedDirector].viewSize;
    float availableWidth = viewSize.width - 2 * SPACING;
    float availableHeight = viewSize.height - 2 * SPACING;

    int cellDimension = (int) MIN((int) availableWidth / GRID_SIZE.width, (int) availableHeight / GRID_SIZE.height);
    _cellSize = CGSizeMake(cellDimension, cellDimension);

}

@end