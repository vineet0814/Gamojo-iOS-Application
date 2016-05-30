//
//  XYZAppDelegate.h
//  ScrollView
//
//  Created by Inclabs Intern on 6/11/14.
//
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"


@interface XYZAppDelegate : UIResponder <UIApplicationDelegate ,REFrostedViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) UINavigationController*myNavigator;
@end
