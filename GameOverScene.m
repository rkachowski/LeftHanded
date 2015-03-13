//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameOverScene.h"


@implementation GameOverScene


- (void)again
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ui"
                                                        object:nil
                                                      userInfo:@{@"message":@"again",
                                                              @"sender": NSStringFromClass([self class])}];
}
@end