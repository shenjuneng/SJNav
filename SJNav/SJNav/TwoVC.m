//
//  TwoVC.m
//  SJNav
//
//  Created by 沈骏 on 2020/8/14.
//  Copyright © 2020 沈骏. All rights reserved.
//

#import "TwoVC.h"
#import "SJNavConfigSingle.h"

@interface TwoVC ()

@end

@implementation TwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SJNavConfigSingle *con = [SJNavConfigSingle shareConfig];
    NSLog(@"%@", con);
    
    self.naviBgColor = UIColor.blueColor;

}
- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
