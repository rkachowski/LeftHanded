//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LevelScene.h"
#import "Grid.h"
#import "Levels.h"


@implementation LevelScene
{

}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];

    [self loadLevel];
}

- (void)loadLevel
{
    SEL levelName = NSSelectorFromString(_levelName);
    NSArray *levelInfo = (NSArray *)[Levels performSelector:levelName];

    [_grid setCellsFromArray:levelInfo];
}

@end