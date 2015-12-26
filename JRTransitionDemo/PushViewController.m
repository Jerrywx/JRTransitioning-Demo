//
//  PushViewController.m
//  JRTransitionDemo
//
//  Created by wxiao on 15/12/26.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor grayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self.navigationController popViewControllerAnimated:YES];
}


@end
