//
//  SJNavConfigSingle.h
//  SJNav
//
//  Created by 沈骏 on 2020/8/14.
//  Copyright © 2020 沈骏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJNavConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface SJNavConfigSingle : NSObject

+ (instancetype)shareConfig;

@property (nonatomic, strong) SJNavConfig *config;

@end

NS_ASSUME_NONNULL_END
