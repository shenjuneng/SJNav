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
// rightButton 和 rightView 不能同时存在
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

//导航栏上的返回按钮
- (UIButton *)leftButton {
    
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(self.config.itemLeftSpace? self.config.itemLeftSpace:DefaultItemLeftRightSpace, kStatusHeight+2, 40, 40)];
        [_leftButton setImage:[UIImage imageNamed:self.config.leftItemImg ? self.config.leftItemImg : @"SJWhite"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.titleLabel.font = self.config.leftFontSize? self.config.leftFontSize : [UIFont systemFontOfSize:17];
    }
    return _leftButton;
}

//导航栏上控制器的标题
- (UILabel *)mtitleLabel {
    if (!_mtitleLabel) {
        _mtitleLabel = [[UILabel alloc] init];
        _mtitleLabel.textAlignment = NSTextAlignmentCenter;
        _mtitleLabel.font = self.config.titleFontSize? self.config.titleFontSize : [UIFont systemFontOfSize:17];
        _mtitleLabel.textColor = self.config.titleColor? self.config.titleColor : UIColor.blackColor;
    }
    return _mtitleLabel;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusHeight+2, 50, 40)];
        _rightButton.right = kWidth - (self.config.itemRightSpace ? self.config.itemRightSpace : DefaultItemLeftRightSpace);
        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.titleLabel.font = self.config.rightFontSize? self.config.rightFontSize : [UIFont systemFontOfSize:17];
        [self.naviView addSubview:_rightButton];
//        _rightButton.backgroundColor = UIColor.yellowColor;
        if (_rightView) {
            [_rightView removeFromSuperview];
            _rightView = nil;
        }
    }
    return _rightButton;
}

// 通过set方法 添加 rightView
- (void)setRightView:(UIView *)rightView {
    if (!self.navigationController) {
        return;
    }
    if (_rightView) {
        [_rightView removeFromSuperview];
        _rightView = nil;
    }
    if (_rightButton) {
        [_rightButton removeFromSuperview];
    }
    _rightView = rightView;
    _rightView.centerY = kStatusHeight + 44/2;
    _rightView.right = kWidth - (self.config.itemRightSpace ? self.config.itemRightSpace : DefaultItemLeftRightSpace);
    [self.naviView addSubview:_rightView];
}

#pragma mark - set
- (void)setNaviBgColor:(UIColor *)naviBgColor {
    if (!self.navigationController) {
        return;
    }
    _naviBgColor = naviBgColor;
    self.naviView.backgroundColor = naviBgColor;
}

//设置导航栏的透明度
- (void)setNaviAlpha:(CGFloat)naviAlpha {
    if (!self.navigationController) {
        return;//不存在导航栏，设置也没用
    }
    
    if (naviAlpha < 0 || naviAlpha > 1) {
        return;
    }
    _naviAlpha = naviAlpha;
    if (naviAlpha == 0) {
        self.naviView.hidden = YES;
    }else{
        self.naviView.hidden = NO;
    }
    self.naviView.alpha = naviAlpha;
}

//导航栏隐藏
- (void)setHiddenNavigation:(BOOL)hiddenNavigation {
    if (!self.navigationController) {
        return;//不存在导航栏，设置也没用
    }
    _hiddenNavigation = hiddenNavigation;
    self.naviView.hidden = hiddenNavigation;
}

//导航栏底部线条隐藏
- (void)setHiddenNavigationLine:(BOOL)hiddenNavigationLine {
    if (!self.navigationController) {
        return;
    }
    _hiddenNavigationLine = hiddenNavigationLine;
    self.lineView.hidden = hiddenNavigationLine;
}

- (void)setTitleString:(NSString *)titleString {
    if (!self.navigationController) {
        return;
    }
    
    if (titleString.length < 1) {
        return;
    }
    
    //设置title先添加导航栏
    if (self.navigationController.childViewControllers.count > 1) {
        [self naviView];
    }
    _titleString = titleString;

    self.mtitleLabel.text = titleString;
    
    CGSize expectSize = [self.mtitleLabel sizeThatFits:CGSizeMake(100, 100)];

    if (_leftButton) {
        if (expectSize.width > (kWidth - (_leftButton.right+4)*2)) {
            self.mtitleLabel.frame = CGRectMake(0, 0, kWidth - (_leftButton.right+4)*2, 30);
        } else {
            self.mtitleLabel.frame = CGRectMake(0, 0, expectSize.width, 30);
        }
    } else {
        self.mtitleLabel.frame = CGRectMake(0, 0, kWidth - DefaultItemLeftRightSpace*2, 30);
    }
    
    self.mtitleLabel.centerX = self.naviView.centerX;
    self.mtitleLabel.centerY = kStatusHeight + 44/2;
    
    [self.naviView addSubview:self.mtitleLabel];
}

//控制器标题字体大小
- (void)setTitleFontSize:(UIFont *)titleFontSize {
    if (!self.navigationController) {
        return;
    }
    
    if (!_mtitleLabel) {
        return;
    }
    
    if (titleFontSize) {
        _titleFontSize = titleFontSize;
        self.mtitleLabel.font = titleFontSize;
    }
}

//控制器标题字体颜色
- (void)setTitleColor:(UIColor *)titleColor {
    if (!self.navigationController) {
        return;
    }
    
    if (!_mtitleLabel) {
        return;
    }
    
    if (titleColor) {
        _titleColor = titleColor;
        self.mtitleLabel.textColor = titleColor;
    }
}

//设置返回按钮文字，需要根据字数设置宽度
- (void)setLeftItemText:(NSString *)leftItemText withTextColor:(UIColor *)color withWidth:(CGFloat)buttonWidth {
    if (!self.navigationController) {
        return;
    }
    
    if (self.navigationController.childViewControllers.count <= 1) {
        [self.leftButton setImage:nil forState:UIControlStateNormal];
        [self.leftButton setTitle:nil forState:UIControlStateNormal];
        [_naviView addSubview:self.leftButton];
    }
    
    if (leftItemText.length > 0) {
        [self.leftButton setTitle:leftItemText forState:UIControlStateNormal];
    }
    
    if (color) {
        [self.leftButton setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (buttonWidth > 0) {
        self.leftButton.width = buttonWidth;
        self.leftButton.x = self.config.itemLeftSpace ? self.config.itemLeftSpace : DefaultItemLeftRightSpace;
    }
}

//设置右边按钮文字，需要根据字数设置宽度
- (void)setRightItemText:(NSString *)rightItemText withTextColor:(UIColor *)color withWidth:(CGFloat)buttonWidth {
    
    if (!self.navigationController) {
        return;
    }
    
    [self.rightButton setImage:nil forState:UIControlStateNormal];
    
    if (rightItemText.length > 0) {
        [self.rightButton setTitle:rightItemText forState:UIControlStateNormal];
    }
    
    if (color) {
        [self.rightButton setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (buttonWidth > 0) {
        self.rightButton.width = buttonWidth;
        self.rightButton.right = kWidth - (self.config.itemRightSpace ? self.config.itemRightSpace : DefaultItemLeftRightSpace);
    }
}

//设置右边按钮图片，需要根据字数设置宽度
- (void)setRightItemImg:(UIImage *)rightImg withWidth:(CGFloat)buttonWidth {
    if (!self.navigationController) {
        return;
    }
    
    [self.rightButton setTitle:@"" forState:UIControlStateNormal];
    
    if (rightImg) {
        [self.rightButton setImage:rightImg forState:UIControlStateNormal];
    }
    
    if (buttonWidth > 0) {
        self.rightButton.width = buttonWidth;
    }
}

//item左边距离
- (void)setItemLeftSpace:(CGFloat)itemLeftSpace {
    if (!self.navigationController) {
        return;
    }
    
    if (itemLeftSpace >= 0) {
        _itemLeftSpace = itemLeftSpace;
        self.leftButton.x = itemLeftSpace;
    }
}

//左边item字体大小
- (void)setLeftFontSize:(UIFont *)leftFontSize {
    if (!self.navigationController) {
        return;
    }
    
    if (leftFontSize) {
        _leftFontSize = leftFontSize;
        self.leftButton.titleLabel.font = leftFontSize;
    }
}

//最右边item右边距离
- (void)setItemRightSpace:(CGFloat)itemRightSpace {
    if (!self.navigationController) {
        return;
    }
    
    if (itemRightSpace >= 0) {
        _itemRightSpace = itemRightSpace;
        if (_rightView) {
            _rightView.right = kWidth - itemRightSpace;
        }
        
        if (_rightButton) {
            _rightButton.right = kWidth - itemRightSpace;
        }
    }
}

//右边item字体大小
- (void)setRightFontSize:(UIFont *)rightFontSize {
    if (!self.navigationController) {
        return;
    }
    
    if (rightFontSize && _rightButton) {
        _rightFontSize = rightFontSize;
        _rightButton.titleLabel.font = rightFontSize;
    }
}

#pragma mark - buttonAction
//pop
- (void)leftButtonAction:(UIButton *)sender {
    if (self.navigationController.childViewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//right
- (void)rightButtonAction:(UIButton *)sender {
    
}

@end
