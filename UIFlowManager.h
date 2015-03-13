//
// Created by Donald Hutchison on 28/02/15.
// Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFlowManager : NSObject

+ (UIFlowManager *)sharedManager;

- (void)handleUIMessage:(NSString *)message from:(NSString *)from info:(NSDictionary *)info;
@end