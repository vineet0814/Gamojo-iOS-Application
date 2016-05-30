//
//  UserProfileViewController.h
//  ScrollView
//
//  Created by Inclabs Intern on 6/13/14.
//
//

#import <UIKit/UIKit.h>

@interface UserProfileViewController : UIViewController
{

    IBOutlet UILabel *BadgeLabel;

     IBOutlet UILabel *NameLabel;

     IBOutlet UISegmentedControl *segmentControlUserProfile;

     IBOutlet UIView *profilePicture;

     IBOutlet UITableView *tableDisplayUserProfile;

}
@property (nonatomic, assign)NSString*setcurrentusername ;
@property (nonatomic,assign)NSString*setcurrentuseremailID;
@property (nonatomic,assign)NSInteger setcurrentMojocoins;
@property (nonatomic,assign)NSString*setcurrentxppoints;
@property (nonatomic,assign)NSString*userID_gameID;


-(void)setCurrentUserName:(NSString*)usernameStr;
-(void)setCurrentUserBadge:(NSString*)BadgeStr;
-(void)setcurrentMojocoins:(NSInteger)MojoStr;
-(void)setcurrentxppoints:(NSString*)xppointsStr;
-(void)setUserID_gameID:(NSString *)userID_gameID;

- (IBAction)segControlUserProfile:(id)sender;

@end
