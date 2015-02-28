//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GridCell.h"


@implementation GridCell
{

    NSString *_type;
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


- (void)setCellType:(NSString *)aChar
{
    if([aChar isEqualToString:@"S"])
    {
        self.color = [CCColor redColor];
        self.isSolid = !self.isSolid;
    }
    else if ([aChar isEqualToString:@"P"])
    {
        self.isSolid = NO;
        self.color = [CCColor blueColor];
        self.opacity = 0.4;
    }
    else if ([aChar isEqualToString:@"W"])
    {
        self.isSolid = NO;
        self.color = [CCColor greenColor];
        self.opacity = 0.4;
    }

    _type = aChar;

}
@end