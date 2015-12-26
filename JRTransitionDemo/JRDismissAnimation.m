//
//  JRDismissAnimation.m
//  JRTransitionDemo
//
//  Created by wxiao on 15/12/26.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import "JRDismissAnimation.h"

@implementation JRDismissAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContextn {
	return 0.6f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
	[self animationTransition2:transitionContext];
}

- (void)animationTransition1:(id <UIViewControllerContextTransitioning>)transitionContext {
	// 1. Get controllers from transition context
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	// 2. Set init frame for fromVC
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
	CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
	CGRect finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height);
	
	// 4. Do animate now
	NSTimeInterval duration = [self transitionDuration:transitionContext];
	[UIView animateWithDuration:duration
					 animations:^{
						 fromVC.view.frame = finalFrame;
						 NSLog(@"----- %@", NSStringFromCGRect(finalFrame));
					 } completion:^(BOOL finished) {
						 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
					 }];

}

- (void)animationTransition2:(id <UIViewControllerContextTransitioning>)transitionContext {
	
	// 1. Get controllers from transition context
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	// 2. Set init frame for fromVC
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
					 animations:^{
						 fromVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, 0, 0);
						 fromVC.view.alpha = 0.0;
					 } completion:^(BOOL finished) {
						 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
					 }];

}

@end
