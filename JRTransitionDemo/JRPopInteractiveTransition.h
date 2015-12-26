//
//  JRPopInteractiveTransition.h
//  JRTransitionDemo
//
//  Created by wxiao on 15/12/26.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRPopInteractiveTransition : UIPercentDrivenInteractiveTransition
@property(nonatomic,assign)BOOL interacting;
-(void)addPopGesture:(UIViewController *)viewController;
@end
