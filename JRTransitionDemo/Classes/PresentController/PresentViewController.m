//
//  PresentViewController.m
//  JRTransitionDemo
//
//  Created by wxiao on 15/12/26.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import "PresentViewController.h"

@interface PresentViewController ()

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.backgroundColor = [UIColor orangeColor];
	
	UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, 60, 32)];
	closeBtn.backgroundColor = [UIColor grayColor];
	[closeBtn setTitle:@"CLOSE" forState:UIControlStateNormal];
	[closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:closeBtn];
}

- (void)close {
	if ([self.delegate respondsToSelector:@selector(modalViewControllerDidClickedDismissButton:)]) {
		[self.delegate modalViewControllerDidClickedDismissButton:self];
	}
}

@end
