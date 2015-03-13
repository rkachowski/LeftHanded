//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "WinScene.h"


@implementation WinScene
{

}


- (void)again
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ui"
                                                        object:nil
                                                      userInfo:@{@"message":@"again",
                                                              @"sender": NSStringFromClass([self class])}];
}

@end