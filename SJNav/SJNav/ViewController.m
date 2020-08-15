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
}


@end
