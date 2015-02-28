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

#define SWIPE_DISTANCE 150

@implementation LevelScene
{

    CGPoint _startLocation;
    GridCharacter *_guy;
    CGPoint _bufferedDir;
    BOOL _buffer;
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
    GridCell *spawn = _grid.spawn;

    _guy = [[GridCharacter alloc] initWithImageNamed:@"guy 1.png"];
    _guy.position = ccpAdd(spawn.position,ccp(20, 20));

    [_objects addChild:_guy];
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

    if (endLocation.x < _startLocation.x && ccpDistance(_startLocation, endLocation) > SWIPE_DISTANCE)
    {
        if([self canMove:_guy])
        {
            _guy.direction = [_guy nextDirection];
        }
        else
        {
            [self bufferDirection:[_guy nextDirection]];
        }
    }
    
    [super touchEnded:touch withEvent:event];
}

- (void)bufferDirection:(CGPoint)point
{
    NSLog(@"buffer!");
    _bufferedDir = point;
    _buffer = YES;
}

- (BOOL)canMove:(GridCharacter *)character
{
    GridCell *cell = [_grid cellAtPoint:[self getBehindPoint:character]];
    if (!cell) return NO;

    CGPoint desiredDirection = [character nextDirection];

    CGPoint desiredCellLocation = ccpAdd(desiredDirection, cell.gridPosition);
    GridCell *desiredCell = [_grid getCell:desiredCellLocation];
    if (!desiredCell) return NO;;

    return !desiredCell.isSolid;
}

- (CGPoint)getBehindPoint:(GridCharacter *)character
{
    CGPoint charPosition = character.position;
    CGPoint behindChar = ccpMult(ccpFromSize(character.contentSize), -0.5);

    CGPoint testPosition = ccpAdd(charPosition, behindChar);
    return testPosition;
}

- (CGPoint)getFrontPoint:(GridCharacter *)character
{
    CGPoint charPosition = character.position;
    CGPoint behindChar = ccpMult(ccpFromSize(character.contentSize), 0.5);

    CGPoint testPosition = ccpAdd(charPosition, behindChar);
    return testPosition;
}

- (void)update:(CCTime)delta
{
    if(_buffer)
    {
        if ([self canMove:_guy])
        {
            _guy.direction = _bufferedDir;
            _buffer = NO;
        }
    }

    [self checkInFront];

    GridCell *cell = [_grid cellAtPoint:_guy.position];

    if ([cell.type isEqualToString:@"E"])
    {
        //you exit
    }
    else if ([cell.type isEqualToString:@"W"])
    {
        //you die
    }
    else if ([cell.type isEqualToString:@"T"])
    {
        //you teleport
    }

}

- (void)checkInFront
{
    GridCell *cell = [_grid cellAtPoint:[self getBehindPoint:_guy]];
    CGPoint nextCellLocation = ccpAdd(cell.gridPosition, _guy.direction);
    GridCell *nextCell = [_grid getCell:nextCellLocation];

    if(!nextCell || nextCell.isSolid)
    {
        if([self canMove:_guy])
        {
            NSLog(@"auto change!");
            _guy.direction = [_guy nextDirection];
        }
        else
        {
            //die! i would rather die than turn right!
        }
    }
}


@end