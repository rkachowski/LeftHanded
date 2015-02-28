//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "LevelScene.h"
#import "Grid.h"
#import "Levels.h"
#import "GridCharacter.h"
#import "GridCell.h"


@implementation LevelScene
{

    CGPoint _startLocation;
    GridCharacter *_guy;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.userInteractionEnabled = YES;
    }

    return self;
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];

    [self loadLevel];
    [self setup];
}

- (void)setup
{
    //get spawn
    GridCell *spawn = _grid.spawn;

    _guy = [[GridCharacter alloc] initWithImageNamed:@"guy 1.png"];
    _guy.position = spawn.position;
    [_objects addChild:_guy];
    //add a character there
    //find direction for character to go
}

- (void)loadLevel
{
    SEL levelName = NSSelectorFromString(_levelName);
    NSArray *levelInfo = (NSArray *)[Levels performSelector:levelName];

    [_grid setCellsFromArray:levelInfo];
}


#pragma mark - swipe

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    _startLocation = [touch locationInNode:self];
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint endLocation = [touch locationInNode:self];

    if (endLocation.x < _startLocation.x && ccpDistance(_startLocation, endLocation) > 60)
    {
        NSLog(@"Swipe!");
        [_guy nextDirection];
    }
    
    [super touchEnded:touch withEvent:event];
}


@end