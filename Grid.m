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

- (id)initWithTexture:(CCTexture *)texture rect:(CGRect)rect rotated:(BOOL)rotated
{
    self = [super initWithTexture:texture rect:rect rotated:rotated];
    if (self)
    {
        self.userInteractionEnabled = YES;
    }

    return self;
}


- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    [self calculateGridSize];
    [self createCells];

    [self drawDebugGrid];
}

- (void)drawDebugGrid
{
    GridCell *firstCell = _cells[0][0];

    for (int x = -1; x <= GRID_SIZE.width; x++)
    {
        CCNodeColor *line = [[CCNodeColor alloc] initWithColor:[CCColor blackColor]
                                                         width:1 height:GRID_SIZE.height * _cellSize.height];
        line.opacity = 0.2;


        CGPoint position = ccp(x * (_cellSize.width) + SPACING, firstCell.position.y);
        line.position = position;

        [self addChild:line];
    }

    for (int y = -1; y <= GRID_SIZE.height; y++)
    {
        CCNodeColor *line = [[CCNodeColor alloc] initWithColor:[CCColor blackColor]
                                                         width:GRID_SIZE.width * _cellSize.width height:1];
        line.opacity = 0.8;


        CGPoint position = ccp(firstCell.position.x, y * (_cellSize.height) + SPACING);
        line.position = position;

        [self addChild:line];
    }
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

            cell.anchorPoint = CGPointZero;
            cell.gridPosition = ccp(x,y);

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

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    NSLog(@"yeah");
}


- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [super touchEnded:touch withEvent:event];
    NSLog(@"yey");
}


@end