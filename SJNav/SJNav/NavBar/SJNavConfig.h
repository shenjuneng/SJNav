//
//  SJNavConfig.h
//  SJNav
//
//  Created by 沈骏 on 2020/8/14.
//  Copyright © 2020 沈骏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJNavConfig : NSObject

//左边返回item字体大小
@property (nonatomic, strong) UIFont *leftFontSize;
//控制器标题字体大小
@property (nonatomic, strong) UIFont *titleFontSize;
//控制器标题字体颜色
@property (nonatomic, strong) UIColor *titleColor;


//右边item字体大小
@property (nonatomic, strong) UIFont *rightFontSize;

@property (nonatomic,   copy) NSString *leftItemImg;

@property (nonatomic, assign) CGFloat itemLeftSpace;


//最右边item右边距离
@property (nonatomic, assign) CGFloat itemRightSpace;

@property (nonatomic, strong) UIColor *naviBgColor;

@property (nonatomic,   copy) NSString *naviBgImg;

@property (nonatomic, assign) BOOL lineHidden;

@end

NS_ASSUME_NONNULL_END
