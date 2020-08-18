//
//  ViewController.m
//  SJNav
//
//  Created by 沈骏 on 2020/8/13.
//  Copyright © 2020 沈骏. All rights reserved.
//

#import "ViewController.h"
#import "SJNavConfigSingle.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SJNavConfigSingle *con = [SJNavConfigSingle shareConfig];
    NSLog(@"%@", con);
    
//    self.naviBgColor = UIColor.redColor;
    
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    rightView.backgroundColor = UIColor.redColor;
//    self.rightView = rightView;
    
    [self setRightItemText:@"999" withTextColor:UIColor.redColor withWidth:60];
    
    [self setRightFontSize:[UIFont systemFontOfSize:30]];
}


@end
