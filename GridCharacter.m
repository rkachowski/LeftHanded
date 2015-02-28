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
        self.direction = ccp(1, 0);
        self.speed = 4;
    }

    return self;
}


- (void)onEnter
{
    [super onEnter];

    NSArray *frames = @[
            [CCSpriteFrame frameWithImageNamed:@"dude01_01.png"],
            [CCSpriteFrame frameWithImageNamed:@"dude01_2.png"]
    ];
    CCAnimation * dance = [CCAnimation animationWithSpriteFrames:frames delay:0.1];

    [self runAction:[CCActionRepeatForever actionWithAction:
    [CCActionAnimate actionWithAnimation:dance]]];


}

- (void)update:(CCTime)delta
{
    self.position = ccpAdd(self.position, ccpMult(self.direction, self.speed));
}

- (CGPoint)nextDirection
{
    if ((int) self.direction.x == 1 && (int) self.direction.y == 0)
    {
        return ccp(0, 1);
    } else if ((int) self.direction.x == 0 && (int) self.direction.y == 1)
    {
        return ccp(-1, 0);
    }
    else if ((int) self.direction.x == -1 && (int) self.direction.y == 0)
    {
        return ccp(0, -1);
    } else if ((int) self.direction.x == 0 && (int) self.direction.y == -1)
    {
        return ccp(1, 0);
    }
}

@end