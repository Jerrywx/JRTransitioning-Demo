//
//  PresentViewController.h
//  JRTransitionDemo
//
//  Created by wxiao on 15/12/26.
//  Copyright © 2015年 wxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PresentViewController;
@protocol PresentViewControllerDelegate <NSObject>
-(void) modalViewControllerDidClickedDismissButton:(PresentViewController *)viewController;
@end

@interface PresentViewController : UIViewController
@property (nonatomic, weak) id<PresentViewControllerDelegate> delegate;
@end
