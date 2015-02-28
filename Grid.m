//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Grid.h"
#import "GridCell.h"

static const CGSize GRID_SIZE = {.height = 12, .width = 24};
static const int SPACING = 20;

@implementation Grid
{
    NSMutableArray *_cells;
    BOOL _drawing;
    NSMutableSet *_drawnSet;
}


@synthesize cellSize;

+ (Grid*)fromCells:(NSArray*)gridData
{
    Grid *grid = [[Grid alloc] init];


    [grid setCellsFromArray:gridData];

    return grid;
}

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

            if([gridChar isEqualToString:@"S"])
            {
                currentCell.isSolid = YES;
            }
        }
    }
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


- (void)toggleCell:(GridCell *)cell
{
    if(_drawnSet && cell && ![_drawnSet containsObject:cell])
    {
        [_drawnSet addObject:cell];

        cell.isSolid = !cell.isSolid;
    }
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    _drawnSet = [NSMutableSet set];
    
    GridCell *cell = [self cellAtPoint:[touch locationInNode:self]];

    [self toggleCell:cell];
}


- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    GridCell *cell = [self cellAtPoint:[touch locationInNode:self]];
    
    [self toggleCell:cell];
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [super touchEnded:touch withEvent:event];
    _drawnSet = nil;
}

- (GridCell*)cellAtPoint:(CGPoint)point
{
    CGPoint gridCoords = [self pointToGridCoords:point];
    GridCell *result = nil;

    @try
    {
        result = _cells[(NSUInteger) gridCoords.x][(NSUInteger)gridCoords.y];
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




@end