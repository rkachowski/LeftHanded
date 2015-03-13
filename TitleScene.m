//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "TitleScene.h"


@implementation TitleScene
{

}

- (void)play
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ui"
                                                        object:nil
                                                      userInfo:@{@"message":@"play",
                                                              @"sender": NSStringFromClass([self class])}];
}
@end