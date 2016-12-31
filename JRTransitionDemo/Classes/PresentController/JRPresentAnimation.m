//
//  JRPresentAnimation.m
//  JRTransitionDemo
//
//  Created by wxiao on 15/12/26.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import "JRPresentAnimation.h"

@implementation JRPresentAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
	return 0.8f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
	
	[self animation2:transitionContext];
}

- (void)animation1:(id <UIViewControllerContextTransitioning>)transitionContext {
	
	// 1. Get controllers from transition context
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	// 2. Set init frame for toVC
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
	CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
	toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
	
	// 3. Add toVC's view to containerView
	UIView *containerView = [transitionContext containerView];
	[containerView addSubview:toVC.view];
	
	// 4. Do animate now
	NSTimeInterval duration = [self transitionDuration:transitionContext];
	[UIView animateWithDuration:duration
						  delay:0.0
		 usingSpringWithDamping:0.6
		  initialSpringVelocity:0.0
						options:UIViewAnimationOptionCurveLinear
					 animations:^{
						 toVC.view.frame = finalFrame;
					 } completion:^(BOOL finished) {
						 // 5. Tell context that we completed.
						 [transitionContext completeTransition:YES];
					 }];
}

- (void)animation2:(id <UIViewControllerContextTransitioning>)transitionContext {
	
	// 1. Get Controller Frome TransitionContext
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIView *containerView = [transitionContext containerView];
	[containerView addSubview:toVC.view];
	
	toVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
	
	toVC.view.alpha = 0.0;
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
					 animations:^{
						 toVC.view.frame = [UIScreen mainScreen].bounds;
						 toVC.view.alpha = 1.0;
					 }
					 completion:^(BOOL finished) {
						[transitionContext completeTransition:YES];
					 }];
}

@end
