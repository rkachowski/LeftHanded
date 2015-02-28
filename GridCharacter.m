//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GridCharacter.h"


@implementation GridCharacter
{

}
- (id)initWithTexture:(CCTexture *)texture rect:(CGRect)rect rotated:(BOOL)rotated
{
    self = [super initWithTexture:texture rect:rect rotated:rotated];
    if (self)
    {
        self.anchorPoint = CGPointZero;
        self.direction = ccp(1, 0);
        self.speed =2;
    }

    return self;
}



- (void)onEnter
{
    [super onEnter];

}

- (void)update:(CCTime)delta
{
    self.position = ccpAdd(self.position, ccpMult(self.direction, self.speed));
}

- (void)nextDirection
{
    if ((int)self.direction.x == 1 && (int)self.direction.y == 0)
    {
        self.direction = ccp(0, 1);
    } else if ((int)self.direction.x == 0 && (int)self.direction.y == 1)
    {
        self.direction = ccp(-1, 0);
    }
    else if ((int)self.direction.x == -1 && (int)self.direction.y == 0)
    {
        self.direction = ccp(0, -1);
    } else if ((int)self.direction.x == 0 && (int)self.direction.y == -1)
    {
        self.direction = ccp(1, 0);
    }
}

@end