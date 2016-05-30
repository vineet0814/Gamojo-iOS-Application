//
//  LoginViewController.m
//  ScrollView
//
//  Created by Inclabs Intern on 6/13/14.
//
//

#import "LoginViewController.h"
#import "UserProfileViewController.h"
#import "MainViewController.h"
#import "MatchCentreViewController.h"
#import "PollsViewController.h"
#import "DEMOMenuViewController.h"
#import "DEMONavigationController.h"
#import "CommentViewController.h"
#import "BetsViewController.h"
@interface LoginViewController () <NSURLConnectionDelegate>
{
    NSString *currentUser, *currentMailID;
    NSMutableData *data;
   NSString* usrID_fbID;
    NSString*gamojoID;
    NSString*badge;
    NSString*fullname;
    NSString*emailID;
    NSInteger mojocoins;
    NSNumber*xppoints;

}
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
    loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
   
    
    
}

-(void)postUserData
{
    NSLog(@"in post data %@",usrID_fbID);
    NSLog(@"username parameter %@",currentUser);
    NSLog(@"email parameter %@",currentMailID);

    NSString *bodyData = [NSString stringWithFormat:@"name=%@&email=%@&fbid=%@&action=userDetails",currentUser,currentMailID,usrID_fbID];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://gamojo.inclabs.in/api/users.php"]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
   
    
  
    NSLog(@"request is %@",postRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
    if(conn){
        data=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"data %@",data);
    }
}
#pragma mark NSURL DELEGATES
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data = [[NSMutableData alloc] init];

    [data setLength:0];
    NSLog(@"response %@",response);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data //1
                          
                          options:kNilOptions
                          error:&error];
    NSLog(@"jsondata %@",json);
     gamojoID = [json objectForKey:@"id"]; //2
    badge = [json objectForKey:@"badge"]; //2
    emailID = [json objectForKey:@"email"]; //2
    fullname = [json objectForKey:@"fullname"]; //2
    mojocoins = [[json objectForKey:@"mojocoins"] integerValue]; //2
    xppoints = [json objectForKey:@"xppoints"]; //2
    NSLog(@"gamojo ID: %@", gamojoID); //3
    NSLog(@"mojocoins ID: %d", mojocoins); //3

    NSString*mojocoinsStr = [NSString stringWithFormat:@"%d",mojocoins];
    NSString*xppointsStr = [NSString stringWithFormat:@"%@",xppoints];
    UserProfileViewController*UserProfileView = [[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:nil];
    
    [UserProfileView setCurrentUserName:fullname];
    [UserProfileView setCurrentUserBadge:badge];
    [UserProfileView setcurrentMojocoins:mojocoins];
    [UserProfileView setcurrentxppoints:xppointsStr];
    [UserProfileView setUserID_gameID:gamojoID];
    
    MainViewController*MainView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [MainView setUsrStr:gamojoID];
    
    PollsViewController *PollsView = [[PollsViewController alloc] initWithNibName:@"PollsViewController" bundle:nil];
    [PollsView setUsrid:gamojoID];

    DEMOMenuViewController*DemoView = [[DEMOMenuViewController alloc] initWithNibName:@"DEMOMenuViewController" bundle:nil];
    [DemoView setUserName:fullname];
    
    CommentViewController*commentView = [[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil ];
    [commentView setUserID:gamojoID];
    BetsViewController*betsView = [[BetsViewController alloc] initWithNibName:@"BetsViewController" bundle:nil];
    [betsView setUserID:gamojoID];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)Data {
    // Append the new data to the instance variable you declared
    [data appendData:Data];
}


- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

#pragma mark handling the response of facebook app



// This method will be called when the user information has been fetched

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user  {
    self.profilePictureView.profileID = user.id;
    
    usrID_fbID = user.id;
NSLog(@"usr ID will be used for FB ID %@",usrID_fbID);
    currentUser=self.nameLabel.text = user.name;
    currentMailID=[user objectForKey:@"email"];
    NSLog(@"user mail %@\n data is %@",[user objectForKey:@"email"],user);
    
    [self postUserData];

}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)logView
{
    [loginView setHidden:YES];
    MatchCentreViewController*MatchCentreView = [[MatchCentreViewController alloc] initWithNibName:@"MatchCentreViewController" bundle:nil];
    
    [self.navigationController pushViewController:
     MatchCentreView animated:YES];
 
}

#pragma mark error handling

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
