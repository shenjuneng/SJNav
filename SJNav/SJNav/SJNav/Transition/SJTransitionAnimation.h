//
//  SJTransitionAnimation.h
//  SJNav
//
//  Created by 沈骏 on 2020/8/13.
//  Copyright © 2020 沈骏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJNav.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AnimationCancel)(void);
typedef void(^AnimationFinish)(void);

typedef enum : NSUInteger {
    JumpPush,
    JumpPop,
    JumpPresent,
    Jumpdismiss,
} JumpType;


@interface SJTransitionAnimation : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning>

@property(assign, nonatomic) JumpType animationType;

@property(strong, nonatomic, nullable) UIViewController *fromVC;

@property(strong, nonatomic, nullable) UIViewController *toVC;

@property(assign, nonatomic) BOOL interactive;

@property(strong, nonatomic, nullable) UIView *fromView;

@property(strong, nonatomic, nullable) UIView *toView;

@property(strong, nonatomic, nullable) id<UIViewControllerContextTransitioning> storedContext;

@property(assign, nonatomic) CGFloat pausedTime;


- (void)cancel:(AnimationCancel)cancelBlock;

- (void)finish:(AnimationFinish)finishBlock;

@end

NS_ASSUME_NONNULL_END
