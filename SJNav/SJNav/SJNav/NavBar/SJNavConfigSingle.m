//
//  SJNavConfigSingle.m
//  SJNav
//
//  Created by 沈骏 on 2020/8/14.
//  Copyright © 2020 沈骏. All rights reserved.
//

#import "SJNavConfigSingle.h"

@implementation SJNavConfigSingle

+ (instancetype)shareConfig {
    static SJNavConfigSingle *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SJNavConfigSingle alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
