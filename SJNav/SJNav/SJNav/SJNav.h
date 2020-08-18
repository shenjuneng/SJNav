//
//  SJNav.h
//  SJNav
//
//  Created by 沈骏 on 2020/8/13.
//  Copyright © 2020 沈骏. All rights reserved.
//  版本号: 2.0.2

#ifndef SJNav_h
#define SJNav_h

#define kHeight   [UIScreen mainScreen].bounds.size.height
#define kWidth  [UIScreen mainScreen].bounds.size.width

#define kStatusHeight \
({CGFloat sh = 0.0;\
if (@available(iOS 13.0, *)) {\
    sh = [[[[[UIApplication sharedApplication] windows] firstObject] windowScene] statusBarManager].statusBarFrame.size.height;\
} else {\
    sh = 20;\
}\
(sh);})

#define kNaviHeight      (kStatusHeight+44)

#define DefaultItemLeftRightSpace 4

#import "SJBaseNav.h"
#import "SJNavConfig.h"
#import "SJNavConfigSingle.h"
#import "UIView+SJLayout.h"
#import "SJBaseViewController.h"

#endif /* SJNav_h */
