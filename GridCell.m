//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GridCell.h"


@implementation GridCell
{

    NSString *_type;
    BOOL _debug;
}
- (id)initWithColor:(CCColor *)color width:(GLfloat)w height:(GLfloat)h
{
    self = [super initWithColor:color width:w height:h];
    if (self)
    {
        self.isSolid = NO;
        _debug = NO;
        self.opacity = 0;
    }

    return self;
}

- (void)setIsSolid:(BOOL)isSolid
{
    _isSolid = isSolid;

    if(_isSolid)
    {
       if(_debug)  self.opacity = 0.4;
        self.type = @"S";
    }
    else
    {
       if(_debug)  self.opacity = 0;
        self.type = @"#";
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
       if(_debug)  self.opacity = 0.4;
    }
    else if ([aChar isEqualToString:@"W"])
    {
        self.isSolid = NO;
        self.color = [CCColor greenColor];
       if(_debug)  self.opacity = 0.4;
    }
    else if ([aChar isEqualToString:@"E"])
    {
        self.isSolid = NO;
        self.color = [CCColor whiteColor];
       if(_debug)  self.opacity = 0.4;
    }
    else if ([aChar isEqualToString:@"T"])
    {
        self.isSolid = NO;
        self.color = [CCColor purpleColor];
       if(_debug)  self.opacity = 0.4;
    }
    else
    {
        self.type = @"#";
    }

    _type = aChar;

}
@end