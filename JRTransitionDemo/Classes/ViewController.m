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
#import "JRPresentAnimation.h"
#import "JRDismissAnimation.h"
#import "JRInteractiveTransition.h"
#import "JRPopInteractiveTransition.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate,
								UINavigationControllerDelegate, UIViewControllerTransitioningDelegate,
								PresentViewControllerDelegate>
@property (nonatomic, strong) UITableView					*tableView;
@property (nonatomic, strong) JRPushTransition				*pushTransition;
@property (nonatomic, strong) JRPopTransition				*popTransition;

@property (nonatomic, strong) JRPresentAnimation			*presentAnimation;
@property (nonatomic, strong) JRDismissAnimation			*dismissAnimateion;

@property (nonatomic, strong) JRInteractiveTransition		*interactiveTransition;
@property (nonatomic, strong) JRPopInteractiveTransition	*popInteractiveTransition;
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
	return 2;
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
		[self.popInteractiveTransition addPopGesture:push];
		[self.navigationController pushViewController:push animated:YES];
	} else if (indexPath.row == 1) {
		PresentViewController *present = [[PresentViewController alloc] init];
		present.delegate = self;
		present.transitioningDelegate = self;
		present.modalPresentationStyle = UIModalPresentationCustom;
		[self.interactiveTransition wireToViewController:present];
		[self presentViewController:present animated:YES completion:nil];
	}
}

#pragma mark - UInavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
								  animationControllerForOperation:(UINavigationControllerOperation)operation
											   fromViewController:(UIViewController *)fromVC
												 toViewController:(UIViewController *)toVC {

	if (operation == UINavigationControllerOperationPush) {
		return self.pushTransition;
	} else  if (operation == UINavigationControllerOperationPop){
		return self.popTransition;
	}
	return nil;
}

- (void)navigationController:(UINavigationController *)navigationController
	  willShowViewController:(UIViewController *)viewController
					animated:(BOOL)animated {
	NSLog(@"will Show");
}

- (void)navigationController:(UINavigationController *)navigationController
	   didShowViewController:(UIViewController *)viewController
					animated:(BOOL)animated {
	NSLog(@"did Show");
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
	return self.popInteractiveTransition.interacting ? self.popInteractiveTransition : nil;
	return nil;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
																  presentingController:(UIViewController *)presenting
																	  sourceController:(UIViewController *)source {
	NSLog(@"------");
	return self.presentAnimation;
	return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
	NSLog(@"inter Dismiss");
	return self.dismissAnimateion;
	return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
	NSLog(@"present");
	return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
	NSLog(@"inter Dismiss");
	return self.interactiveTransition.interacting ? self.interactiveTransition : nil;
	return nil;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
													  presentingViewController:(UIViewController *)presenting
														  sourceViewController:(UIViewController *)source {
	NSLog(@"=======");
	return nil;
}

#pragma mark - PresentViewControllerDelegate
- (void)modalViewControllerDidClickedDismissButton:(PresentViewController *)viewController {
	[viewController dismissViewControllerAnimated:YES completion:nil];
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

- (JRPresentAnimation *)presentAnimation {
	if (_presentAnimation) {
		return _presentAnimation;
	}
	
	return _presentAnimation = [[JRPresentAnimation alloc] init];
}

- (JRDismissAnimation *)dismissAnimateion {
	if (_dismissAnimateion) {
		return _dismissAnimateion;
	}
	return _dismissAnimateion = [[JRDismissAnimation alloc] init];
}

- (JRInteractiveTransition *)interactiveTransition {
	
	if (_interactiveTransition) {
		return _interactiveTransition;
	}
	return _interactiveTransition = [[JRInteractiveTransition alloc] init];
}

- (JRPopInteractiveTransition *)popInteractiveTransition {
	if (_popInteractiveTransition) {
		return _popInteractiveTransition;
	}
	
	return _popInteractiveTransition = [[JRPopInteractiveTransition alloc] init];
}

@end












