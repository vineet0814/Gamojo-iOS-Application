//
//  LoginViewController.h
//  ScrollView
//
//  Created by Inclabs Intern on 6/13/14.
//
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController : UIViewController <FBLoginViewDelegate>
{
    
    IBOutlet FBLoginView *loginView;
}
@end
