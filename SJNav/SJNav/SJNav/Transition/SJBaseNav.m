//
//  SJBaseNav.m
//  SJNav
//
//  Created by 沈骏 on 2020/8/14.
//  Copyright © 2020 沈骏. All rights reserved.
//

#import "SJBaseNav.h"
#import "SJTransitionAnimation.h"

@interface SJBaseNav ()<UINavigationControllerDelegate>

//滑动进度
@property(assign, nonatomic) CGFloat percentComplete;
// 区分是手势交互还是直接pop/push
@property(assign, nonatomic) BOOL isInteractive;
//添加标识，防止暴力操作
@property(assign, nonatomic) BOOL hold;

@property(strong, nonatomic) SJTransitionAnimation *transitionAnimation;

@end

@implementation SJBaseNav

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.blackColor;
    self.navigationBar.hidden = true;
    self.delegate = self;
    [self addPanGestureAction];
    
}

- (void)addPanGestureAction {
    UIPanGestureRecognizer * ges = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(edgTapAction:)];
    [self.view addGestureRecognizer:ges];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = true;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - action
- (void)edgTapAction:(UIPanGestureRecognizer *)ges {
    // 找到当前点
    CGPoint translation  = [ges translationInView:ges.view];
    // 滑动比例
    self.percentComplete = fabs(translation.x/kWidth);
    self.percentComplete = MIN(MAX(self.percentComplete, 0.01), 0.99);
    if (translation.x < 0) {
        //手势左滑的状态相当于滑动比例为0，
        self.percentComplete = 0.0;
    }
    
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
            self.isInteractive = YES;
            if (self.viewControllers.count > 1) {
                [self popViewControllerAnimated:YES];
            }
            break;
        case UIGestureRecognizerStateChanged:
            [self.transitionAnimation updateInteractiveTransition:self.percentComplete];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            self.isInteractive = NO;
            [ges setEnabled:NO];
            if (self.percentComplete >= 0.5) {
                [self.transitionAnimation finish:^{
                    [ges setEnabled:YES];
                }];
            } else {
                [self.transitionAnimation cancel:^{
                    [ges setEnabled:YES];
                }];
            }
            break;
        default:
            break;
    }
    
}

#pragma mark - nav delegate
//处理push/pop过渡动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        self.transitionAnimation.animationType = JumpPush;
    } else if (operation == UINavigationControllerOperationPop) {
        self.transitionAnimation.animationType = JumpPop;
    }
    return self.transitionAnimation;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if (self.transitionAnimation.animationType == JumpPop) {
        SJTransitionAnimation *an = self.isInteractive == YES ? self.transitionAnimation : nil;
        return an;
    }
    return nil;
}

#pragma mark - 懒加载
- (SJTransitionAnimation *)transitionAnimation {
    if (_transitionAnimation == nil) {
        _transitionAnimation = [[SJTransitionAnimation alloc] init];
    }
    return _transitionAnimation;
}

@end
