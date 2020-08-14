//
//  SJTransitionAnimation.m
//  SJNav
//
//  Created by 沈骏 on 2020/8/13.
//  Copyright © 2020 沈骏. All rights reserved.
//

#import "SJTransitionAnimation.h"

CGFloat const default_scale = 0.9;
CGFloat const timeInterval = 0.3;

@implementation SJTransitionAnimation

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    self.storedContext = transitionContext;
    switch (self.animationType) {
        case JumpPush:
            [self pushAnimation:transitionContext];
            break;
        case JumpPop:
            [self popAnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return timeInterval;
}

#pragma mark - 手势动画
- (void)startInteractiveTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *fromViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    if (fromViewController == nil || toViewController == nil) {
        return;
    }
    
    self.storedContext = transitionContext;
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    self.fromVC = fromViewController;
    self.toVC = toViewController;
    
    self.fromView = fromViewController.view;
    self.toView = toViewController.view;
    
    self.toView.transform = CGAffineTransformMakeScale(default_scale, default_scale);
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    if (self.storedContext == nil) {
        return;
    }

    if (self.toView == nil || self.fromView == nil) {
        return;
    }

    self.fromView.frame = CGRectMake(kWidth*percentComplete, 0, kWidth, kHeight);
    
    CGFloat gap_scale = (1 - default_scale)*percentComplete;
    CGFloat scale =  default_scale + gap_scale;
    self.toView.transform = CGAffineTransformMakeScale(scale, scale);
    [self.storedContext updateInteractiveTransition:percentComplete];
}

- (void)cancel:(AnimationCancel)cancelBlock {
    if (self.toView == nil || self.fromView == nil) {
        cancelBlock();
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.fromView.frame = CGRectMake(0, 0, kWidth, kHeight);
        self.toView.transform = CGAffineTransformMakeScale(default_scale, default_scale);
    } completion:^(BOOL finished) {
        [self.storedContext cancelInteractiveTransition];
        [self.storedContext completeTransition:NO];
        self.storedContext = nil;
        self.toView = nil;
        self.fromView = nil;
        self.toVC.view.transform = CGAffineTransformIdentity;
        cancelBlock();
    }];
}

- (void)finish:(AnimationFinish)finishBlock {
    if (self.toView == nil || self.fromView == nil) {
        finishBlock();
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.fromView.frame = CGRectMake(kWidth, 0, kWidth, kHeight);
        self.toView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        [self.storedContext finishInteractiveTransition];
        [self.storedContext completeTransition:YES];
        self.storedContext = nil;
        self.toView = nil;
        finishBlock();
    }];
}

#pragma mark - 非手势动画
- (void)pushAnimation:(id<UIViewControllerContextTransitioning> )transitionContext {
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是转场后的VC，fromVC就是转场前的VC
    //                         UITransitionContextFromViewControllerKey
    UIViewController *fromViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.fromVC = fromViewController;
    
    UIView *containerView = transitionContext.containerView;
    
    [self.fromVC.tabBarController.tabBar setHidden:YES];
    
    self.toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [containerView addSubview:self.toVC.view];
    
    [containerView insertSubview:self.fromVC.view belowSubview:self.toVC.view];
    
    UIView *fromView = self.fromVC.view;
    UIView *toView = self.toVC.view;
    fromView.frame = CGRectMake(0, 0, kWidth, kHeight);
    toView.frame = CGRectMake(kWidth, 0, kWidth, kHeight);
    [UIView animateWithDuration:timeInterval animations:^{
        fromView.transform = CGAffineTransformMakeScale(default_scale, default_scale);
        toView.frame = CGRectMake(0, 0, kWidth, kHeight);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromView.transform = CGAffineTransformIdentity;
    }];
}

- (void)popAnimation:(id<UIViewControllerContextTransitioning> )transitionContext {
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是转场后的VC，fromVC就是转场前的VC
    UIViewController *fromViewController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.fromVC = fromViewController;
    self.toVC = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    
    UIView *fromView = self.fromVC.view;
    UIView *toView = self.toVC.view;
    
    [containerView insertSubview:self.toVC.view belowSubview:self.fromVC.view];
    
    fromView.frame = CGRectMake(0, 0, kWidth, kHeight);
    toView.frame = CGRectMake(0, 0, kWidth, kHeight);
    toView.transform = CGAffineTransformMakeScale(default_scale, default_scale);
    
    [UIView animateWithDuration:timeInterval animations:^{
        toView.transform = CGAffineTransformIdentity;
        fromView.frame = CGRectMake(kWidth, 0, kWidth, kHeight);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];

}


@end
