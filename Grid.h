//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


@interface Grid : CCSprite
{
    CGSize _cellSize;
}


@property(nonatomic) CGSize cellSize;
@property(nonatomic, strong) NSMutableArray *cells;
@end