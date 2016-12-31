//
//  JRPopInteractiveTransition.m
//  JRTransitionDemo
//
//  Created by wxiao on 15/12/26.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import "JRPopInteractiveTransition.h"

@interface JRPopInteractiveTransition ()
@property (assign , nonatomic) BOOL canReceive;
@property (nonatomic, strong) UIViewController *presentedVC;
@end

@implementation JRPopInteractiveTransition

-(void)addPopGesture:(UIViewController *)viewController{
	_presentedVC = viewController;
	
	UIScreenEdgePanGestureRecognizer *edgeGes = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self
																								 action:@selector(edgeGesPan:)];
	edgeGes.edges = UIRectEdgeLeft;
	[viewController.view addGestureRecognizer:edgeGes];
	
//	============================================================================
//	UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer:)];
//	[viewController.view addGestureRecognizer:pan];

//	============================================================================
	UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer0:)];
	[viewController.view addGestureRecognizer:pan];
}

-(void)panRecognizer0:(UIPanGestureRecognizer *)pan {
	
	CGPoint panPoint = [pan translationInView:pan.view.superview];

	CGFloat percent = panPoint.x / [UIScreen mainScreen].bounds.size.width;
	switch (pan.state) {
		case UIGestureRecognizerStateBegan:{
			self.interacting =  YES;
			//            [presentedVC dismissViewControllerAnimated:YES completion:nil];
			//            如果是navigationController控制，这里应该是
			[_presentedVC.navigationController popViewControllerAnimated:YES];
			break;
		}
		case UIGestureRecognizerStateChanged:{
			
			[self updateInteractiveTransition:percent];
			break;
		}
			
		case UIGestureRecognizerStateEnded:{
			self.interacting = NO;
			if (percent > 0.5) {
				[self finishInteractiveTransition];
				NSLog(@"完成");
			}else{
				[self cancelInteractiveTransition];
				NSLog(@"取消");
			}
			break;
		}
			
		default:
			break;
	}
}

-(void)edgeGesPan:(UIScreenEdgePanGestureRecognizer *)edgeGes{

	CGFloat translation =[edgeGes translationInView:_presentedVC.view].x;
	CGFloat percent = translation / (_presentedVC.view.bounds.size.width/2);
	percent = MIN(0.99, MAX(0.0, percent));
	NSLog(@"%f",percent);
	
	switch (edgeGes.state) {
		case UIGestureRecognizerStateBegan:{
			self.interacting =  YES;
			//            [presentedVC dismissViewControllerAnimated:YES completion:nil];
			//            如果是navigationController控制，这里应该是
			[_presentedVC.navigationController popViewControllerAnimated:YES];
			break;
		}
		case UIGestureRecognizerStateChanged:{
			
			[self updateInteractiveTransition:percent];
			break;
		}
			
		case UIGestureRecognizerStateEnded:{
			self.interacting = NO;
			if (percent > 0.5) {
				[self finishInteractiveTransition];
				NSLog(@"完成");
			}else{
				[self cancelInteractiveTransition];
				NSLog(@"取消");
			}
			break;
		}
			
		default:
			break;
	}
}


-(void)panRecognizer:(UIPanGestureRecognizer *)pan {

	CGPoint panPoint = [pan translationInView:pan.view.superview];
	CGPoint locationPoint = [pan locationInView:pan.view.superview];
	
	if (pan.state == UIGestureRecognizerStateBegan) {
		self.interacting = YES;
		// ------判断初始位置，在屏幕上半段才能触发Pop
		if (locationPoint.y <= self.presentedVC.view.bounds.size.height/2.0) {
			[self.presentedVC.navigationController popViewControllerAnimated:YES];
		}
	}else if (pan.state == UIGestureRecognizerStateChanged){
		
		if (locationPoint.y >= self.presentedVC.view.bounds.size.height/2.0) {
			self.canReceive = YES;
		}else{
			self.canReceive = NO;
		}
		
		[self updateInteractiveTransition:panPoint.y/self.presentedVC.view.bounds.size.height];
		
	}else if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded){
		self.interacting = NO;
		if(!self.canReceive || pan.state == UIGestureRecognizerStateCancelled)
		{
			[self cancelInteractiveTransition];
		}else{
			[self finishInteractiveTransition];
		}
	}
}

@end
