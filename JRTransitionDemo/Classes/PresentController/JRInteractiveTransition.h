//
//  JRInteractiveTransition.h
//  JRTransitionDemo
//
//  Created by wxiao on 15/12/26.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interacting;
- (void)wireToViewController:(UIViewController*)viewController;
@end
