//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GridCell.h"


@implementation GridCell
{

}
- (id)initWithColor:(CCColor *)color width:(GLfloat)w height:(GLfloat)h
{
    self = [super initWithColor:color width:w height:h];
    if (self)
    {
        self.isSolid = NO;

    }

    return self;
}

- (void)setIsSolid:(BOOL)isSolid
{
    _isSolid = isSolid;

    if(_isSolid)
    {
        self.opacity = 0.4;
    }
    else
    {
        self.opacity = 0;
    }
}


@end