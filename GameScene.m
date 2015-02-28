//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameScene.h"
#import "Grid.h"
#import "GridCell.h"
#import "Levels.h"


@implementation GameScene
{

}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.userInteractionEnabled = TRUE;
    }

    return self;
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];

    [_grid setCellsFromArray:[Levels levelOne] ];
}


-(void)outputGrid
{
    NSArray *cells = _grid.cells;
    NSMutableArray *output = [NSMutableArray array];

    for(int x = 0; x < cells.count; x++)
    {
        output[x] = [NSMutableArray array];
        for(int y = 0; y < [cells[0] count]; y++)
        {
            GridCell *currentCell = cells[x][y];
            NSString*blockType = @"#";

            if(currentCell.isSolid)
            {
                blockType = @"S";
            }


            output[x][y] = blockType;
        }
    }
    for(int i = 0; i < output.count; i++)
    {
        output[i] = [output[i] componentsJoinedByString:@","];
    }
    NSLog(@"%@", output);
}


@end