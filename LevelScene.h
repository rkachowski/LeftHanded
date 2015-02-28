//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Grid;
@class GridCharacter;


@interface LevelScene : CCScene

@property (nonatomic) NSString *levelName;
@property (nonatomic) Grid *grid;

@property (nonatomic) CCSprite *background;
@property (nonatomic) CCSprite *gridImage;
@property (nonatomic) CCSprite *objects;

@property(nonatomic) CGPoint startLocation;
@property(nonatomic, strong) GridCharacter *guy;
@end