//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GridCharacter : CCSprite

@property (nonatomic) CGPoint direction;
@property (nonatomic) float speed;

+ (void)setup;

- (void)nextDirection;
@end