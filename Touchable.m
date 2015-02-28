//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Touchable.h"


@implementation Touchable
{

    BOOL _touched;
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];

    //run tween
}

-(void)onTouch
{
    if(!_touched)
    {
        if ([_type isEqualToString:@"statue"])
        {
            [self runFlipAnimation];
        }
        else if ([_type isEqualToString:@"teleport"])
        {

        }

        _touched = YES;
    }
}

- (void)runFlipAnimation
{
    CCAction *scaleUp = [CCActionScaleBy actionWithDuration:0.5 scale:2];
    CCAction *flip = [CCActionScaleTo actionWithDuration:0.5 scaleX:-2 scaleY:2];
    CCAction *scaleDown = [CCActionScaleBy actionWithDuration:0.5 scale:0.0.8];

    CCActionSequence *seq = [CCActionSequence actionWithArray:@[scaleUp, flip,scaleDown]];

    [self runAction:seq];
}

@end