//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Grid;


@interface EditorScene : CCScene

@property (nonatomic) CCSprite *background;
@property (nonatomic) Grid *grid;

@property (nonatomic) CCButton *type;
@property(nonatomic, strong) NSArray *types;
@property(nonatomic, strong) NSMutableSet *drawnSet;
@property(nonatomic, strong) NSDictionary *typeToChar;
@end