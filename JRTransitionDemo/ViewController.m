//
//  ViewController.m
//  JRTransitionDemo
//
//  Created by wxiao on 15/12/26.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import "ViewController.h"
#import "PushViewController.h"
#import "PresentViewController.h"
#import "JRPushTransition.h"
#import "JRPopTransition.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate,
								UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView			*tableView;
@property (nonatomic, strong) JRPushTransition		*pushTransition;
@property (nonatomic, strong) JRPopTransition		*popTransition;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.view.backgroundColor	= [UIColor whiteColor];
	_tableView					= [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
	_tableView.dataSource		= self;
	_tableView.delegate			= self;
	[self.view addSubview:_tableView];
}

#pragma mark - UITableDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [[UITableViewCell alloc] init];
	if (indexPath.row == 0) {
		cell.textLabel.text = @"Push";
	} else {
		cell.textLabel.text = @"Present";
	}
	return cell;
}

#pragma mark - UItableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.row == 0) {
		self.navigationController.delegate = self;
		
		PushViewController *push = [[PushViewController alloc] init];
		[self.navigationController pushViewController:push animated:YES];
	} else if (indexPath.row == 1) {
		PresentViewController *present = [[PresentViewController alloc] init];
		[self presentViewController:present animated:YES completion:nil];
	}
}

#pragma mark - UInavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
	NSLog(@"转场");
	
	if (operation == UINavigationControllerOperationPush) {
		return self.pushTransition;
	} else  if (operation == UINavigationControllerOperationPop){
		return self.popTransition;
	}
	
	return nil;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSLog(@"will Show");
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSLog(@"did Show");
}

#pragma mark - 懒加载
- (JRPushTransition *)pushTransition {
	
	if (_pushTransition) {
		return _pushTransition;
	}
	_pushTransition = [[JRPushTransition alloc] init];
	return _pushTransition;
}

- (JRPopTransition *)popTransition {
	if (_popTransition) {
		return _popTransition;
	}
	return [[JRPopTransition alloc] init];
}

@end












