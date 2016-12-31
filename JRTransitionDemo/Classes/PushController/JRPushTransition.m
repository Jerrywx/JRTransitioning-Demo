//
//  JRPushTransition.m
//  JRTransitionDemo
//
//  Created by wxiao on 15/12/26.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import "JRPushTransition.h"

@implementation JRPushTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
	return 0.8f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

	[self animation2:transitionContext];
}

- (void)animation1:(id<UIViewControllerContextTransitioning>)transitionContext {
	
	UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	CGRect finalFrameForVc = [transitionContext finalFrameForViewController:toVc];
	CGRect bounds = [[UIScreen mainScreen] bounds];
	
	toVc.view.frame = CGRectOffset(finalFrameForVc, 0, bounds.size.height);
	[[transitionContext containerView] addSubview:toVc.view];
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
						  delay:0.0
		 usingSpringWithDamping:0.5
		  initialSpringVelocity:0.0
						options:UIViewAnimationOptionCurveLinear
					 animations:^{
						 fromVc.view.alpha = 0.8;
						 toVc.view.frame = finalFrameForVc;
					 }
					 completion:^(BOOL finished) {
						 [transitionContext completeTransition:YES];
						 fromVc.view.alpha = 1.0;
					 }];
}

- (void)animation2:(id<UIViewControllerContextTransitioning>)transitionContext {
	
//	UIViewController *fromeVC	= [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC		= [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	[[transitionContext containerView] addSubview:toVC.view];
	
	CGRect frame = toVC.view.frame;
	
	toVC.view.frame = CGRectMake(frame.size.width, 0, 0, 0);
	toVC.view.alpha = 0.0;
	
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
					 animations:^{
		toVC.view.alpha = 1.0;
		toVC.view.frame = frame;
	} completion:^(BOOL finished) {
		[transitionContext completeTransition:YES];
	}];
}

@end










