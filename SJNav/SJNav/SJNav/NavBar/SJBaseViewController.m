//
//  SJBaseViewController.m
//  SJNav
//
//  Created by 沈骏 on 2020/8/14.
//  Copyright © 2020 沈骏. All rights reserved.
//

#import "SJBaseViewController.h"
#import "SJNavConfigSingle.h"

@interface SJBaseViewController ()

@property (nonatomic, strong) SJNavConfig *config;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UILabel *mtitleLabel;

@property (nonatomic, strong) UIImageView *naviImgView;

@end

@implementation SJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view.
        
    self.view.backgroundColor = UIColor.whiteColor;
    
    //存在导航栏才添加
    if (self.navigationController) {
        [self.navigationController.navigationBar setHidden:YES];
        self.config = [SJNavConfigSingle shareConfig].config;
        self.titleString = self.navigationItem.title;
        if (@available(iOS 11, *)) {
            self.additionalSafeAreaInsets = UIEdgeInsetsMake(44, 0, 0, 0);
        }
        
        
        [self.view addSubview:self.naviView];
    }
}

#pragma mark - 懒加载 get
// 导航栏
- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kNaviHeight)];
        _naviView.backgroundColor = self.config.naviBgColor ? self.config.naviBgColor : UIColor.whiteColor;
        
        [_naviView addSubview:self.naviImgView];
        [_naviView addSubview:self.lineView];
        //除了首页的控制器才有返回按钮
        if (self.navigationController.childViewControllers.count > 1) {
            [_naviView addSubview:self.leftButton];
        }
    }
    return _naviView;
}

// 导航栏背景图片
- (UIImageView *)naviImgView {
    if (!_naviImgView) {
        _naviImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kNaviHeight)];
        //设置默认图片
        _naviImgView.image = self.config.naviBgImg? [UIImage imageNamed:self.config.naviBgImg] : nil;
        _naviImgView.hidden = self.config.naviBgImg? NO : YES;
    }
    return _naviImgView;
}

//导航栏的横线
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _naviView.height-0.5, kWidth, 0.5)];
        _lineView.backgroundColor = UIColor.grayColor;
        _lineView.alpha = 0.5;
        _lineView.hidden = self.config.lineHidden;
    }
    return _lineView;
}



#pragma mark - set
- (void)setNaviBgColor:(UIColor *)naviBgColor {
    if (!self.navigationController) {
        return;
    }
    _naviBgColor = naviBgColor;
    self.naviView.backgroundColor = naviBgColor;
}


@end
