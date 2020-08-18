//
//  UIView+SJLayout.h
//  SJNav
//
//  Created by 沈骏 on 2020/8/15.
//  Copyright © 2020 沈骏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SJLayout)

/**  起点x坐标  */
@property (nonatomic, assign) CGFloat x;
/**  起点y坐标  */
@property (nonatomic, assign) CGFloat y;
/**  中心点x坐标  */
@property (nonatomic, assign) CGFloat centerX;
/**  中心点y坐标  */
@property (nonatomic, assign) CGFloat centerY;
/**  底部坐标  */
@property (nonatomic, assign) CGFloat bottom;
/**  右边坐标 */
@property (nonatomic, assign) CGFloat right;
/**  宽度  */
@property (nonatomic, assign) CGFloat width;
/**  高度  */
@property (nonatomic, assign) CGFloat height;
/**  size  */
@property (nonatomic, assign) CGSize size;
/**  origin */
@property (nonatomic, assign) CGPoint origin;

@end

NS_ASSUME_NONNULL_END
