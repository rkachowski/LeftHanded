//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "Grid.h"
#import "GridCell.h"
#import "CCEffect_Private.h"

static const CGSize GRID_SIZE = {.height = 12, .width = 24};
static const int SPACING = 20;

@implementation Grid
{
    NSMutableArray *_cells;
    NSMutableSet *_drawnSet;
}

@synthesize cellSize;

- (void)setCellsFromArray:(NSArray *)array
{
    for(int x = 0; x < array.count; x++)
    {
        NSString *columnData = array[x];
        NSArray *column = [columnData componentsSeparatedByString:@","];
        for (int y = 0; y < [column count]; y++)
        {
            NSString *gridChar = column[y];
            GridCell *currentCell = _cells[x][y];

            [currentCell setCellType:gridChar];

            if([gridChar isEqualToString:@"P"])
            {
                _spawn = currentCell;
            }
        }
    }
}

- (GridCell *)spawn
{
    if(!_spawn)
    {
        for (int x = 0; x < GRID_SIZE.width; x++)
        {
            for (int y = 0; y < GRID_SIZE.height; y++)
            {
                GridCell *currentCell = _cells[x][y];
                if([currentCell.type isEqualToString:@"P"])
                {
                    _spawn = currentCell;
                    break;
                }
            }
        }
    }

    return _spawn;
}


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


- (GridCell*)cellAtPoint:(CGPoint)point
{
    CGPoint gridCoords = [self pointToGridCoords:point];
    return [self getCell:gridCoords];

}

- (GridCell *)getCell:(CGPoint )gridCoords
{
    GridCell *result = nil;

    @try
    {
        result = _cells[(NSUInteger) (gridCoords).x][(NSUInteger) (gridCoords).y];
    }
    @catch (NSException *ex)
    {
        //OOB
    }

    return result;
}

- (CGPoint)pointToGridCoords:(CGPoint)point
{
    float column = floor((point.x - SPACING) / _cellSize.width);
    float row = floor((point.y - SPACING) / _cellSize.height);

    return ccp(column,row);
}

-(void)printGrid
{
    NSArray *cells = _cells;
    NSMutableArray *output = [NSMutableArray array];

    for(int x = 0; x < cells.count; x++)
    {
        output[x] = [NSMutableArray array];
        for(int y = 0; y < [cells[0] count]; y++)
        {
            GridCell *currentCell = cells[x][y];

            output[x][y] = currentCell.type;
        }
    }
    for(int i = 0; i < output.count; i++)
    {
        output[i] = [output[i] componentsJoinedByString:@","];
    }

    NSLog(@"%@", output);
}


- (void)setCell:(GridCell *)cell toType:(NSString *)type
{
    [cell setCellType:type];
}

@end