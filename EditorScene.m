//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "EditorScene.h"
#import "Grid.h"
#import "GridCell.h"
#import "Levels.h"


@implementation EditorScene
{

    NSArray *_types;
    NSMutableSet *_drawnSet;
    NSDictionary *_typeToChar;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.userInteractionEnabled = TRUE;
        

        _types = @[
                @"block",
                @"spawn",
                @"window",
                @"exit"
        ];
        

        _typeToChar = @{
                @"block":@"S",
                @"spawn":@"P",
                @"window":@"W",
                @"exit":@"E"
        };

    }

    return self;
}

- (void)onEnter
{
    [super onEnter];

    [self setEditType:_types[0]];
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    _drawnSet = [NSMutableSet set];

    GridCell *cell = [_grid cellAtPoint:[touch locationInNode:self]];
    [self changeCell:cell];
}

- (void)changeCell:(GridCell *)cell
{
    if(_drawnSet && cell && ![_drawnSet containsObject:cell])
    {
        [_drawnSet addObject:cell];
        [_grid setCell:cell toType:_typeToChar[_type.label.string]];
    }
}

- (void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    GridCell *cell = [_grid cellAtPoint:[touch locationInNode:self]];
    [self changeCell:cell];
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [super touchEnded:touch withEvent:event];
    _drawnSet = nil;
}

- (void)setEditType:(NSString*)o
{
    _type.label.string = o;
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];

    [_grid setCellsFromArray:[Levels levelOne] ];
}



- (void)changeType
{
    NSUInteger newIndex = [_types indexOfObject:_type.label.string] + 1;
    if (newIndex == _types.count)
    {
        newIndex = 0;
    }

    [self setEditType:_types[newIndex]];

}

- (void)outputGrid
{
    [_grid printGrid];
}

@end