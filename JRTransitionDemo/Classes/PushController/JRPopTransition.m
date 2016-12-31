//
//  JRPopTransition.m
//  JRTransitionDemo
//
//  Created by wxiao on 15/12/26.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import "JRPopTransition.h"

@implementation JRPopTransition 


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
	
	toVc.view.frame = CGRectOffset(finalFrameForVc, 0, -bounds.size.height);
	
	[[transitionContext containerView] addSubview:toVc.view];
	
	
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
						  delay:0.0
		 usingSpringWithDamping:0.5
		  initialSpringVelocity:0.0
						options:UIViewAnimationOptionCurveLinear
					 animations:^{
						 fromVc.view.alpha = 0.0;
						 toVc.view.frame = finalFrameForVc;
					 }
					 completion:^(BOOL finished) {
						 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
						 fromVc.view.alpha = 1.0;
					 }];
}

- (void)animation2:(id<UIViewControllerContextTransitioning>)transitionContext {
	
	UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	CGRect finalFrameForVc = [transitionContext finalFrameForViewController:toVc];
	CGRect bounds = [[UIScreen mainScreen] bounds];
	
	toVc.view.frame = finalFrameForVc;
	//	[[transitionContext containerView] addSubview:toVc.view];
	[[transitionContext containerView] insertSubview:toVc.view belowSubview:fromVc.view];
	
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
					 animations:^{
						 fromVc.view.alpha = 0.0;
						 fromVc.view.frame = CGRectMake(bounds.size.width, 0, 0, 0);
					 }
					 completion:^(BOOL finished) {
						 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
					 }];
}

@end
