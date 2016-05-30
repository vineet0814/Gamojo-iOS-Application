//
//  UserProfileViewController.m
//  ScrollView
//
//  Created by Inclabs Intern on 6/13/14.
//
//

#import "UserProfileViewController.h"
#import "LoginViewController.h"
#import "DEMONavigationController.h"
#import "DEMOMenuViewController.h"

@interface UserProfileViewController () <NSURLConnectionDelegate>
{
    NSArray*Stats;
    NSMutableArray*Activity;
    NSMutableArray*Network;
    NSInteger selectedSegment;
    NSMutableData* getActivity;
}



@end

@implementation UserProfileViewController
@synthesize setcurrentusername;

static NSString *BadgeDisplay;
static NSString *usernameDisplay;
static  NSInteger  MojoDisplay;

static NSString *xppointsDisplay;
static   NSString* usrID ;

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
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:(DEMONavigationController *)self.navigationController
                                                                             action:@selector(showMenu)];
    
    
    NameLabel.text = usernameDisplay;
    BadgeLabel.text = BadgeDisplay;
    selectedSegment =0;
    

    
    
    Stats = [[NSMutableArray alloc]init];
    Activity = [[NSMutableArray alloc]initWithObjects:@"aaaa",@"bbbb", nil];
    Network = [[NSMutableArray alloc]initWithObjects:@"tttttt",@"xxxxxx", nil];
    [self getActLog];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegate methods (mandatory) for table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}




-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    
    
    int Count=0;
    
    if(selectedSegment==0){
        Count = 1;
        
    }

    
 
    
    if(selectedSegment==1){
        Count = [Activity count];
        
    }
    
    if(selectedSegment==2){
        Count = [Network count];
        
    }
    
    return Count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    
    
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if(selectedSegment==0){

        UIView* contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 307)];
        UILabel* mojoCoin = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 200, 30)];
        mojoCoin.text = [NSString stringWithFormat:@"MojoCoins : %d ",MojoDisplay];
        [contentView addSubview:mojoCoin];
        [cell addSubview:contentView];
    }

   
    if(selectedSegment==1){
        cell.textLabel.text=[Activity objectAtIndex:indexPath.row];
    }
    if(selectedSegment==2){
        cell.textLabel.text = [Network objectAtIndex:indexPath.row];
    }
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int height =0 ;
    
    if (tableView == tableDisplayUserProfile) {
        if(selectedSegment == 0){
            height = 307;
        }
        if(selectedSegment ==1 ){
            height = 80 ;
        }
        if(selectedSegment ==2){
            height = 80;
        }
    }
    return height;
}



-(IBAction)segControlUserProfile:(id)sender{
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment==0){

        [tableDisplayUserProfile reloadData];

    
    }
    if(selectedSegment==1){
        [tableDisplayUserProfile reloadData];
    }
    if(selectedSegment==2){
        [tableDisplayUserProfile reloadData];
    }
    
    
}


-(void)setCurrentUserName:(NSString *)usernameStr{
    usernameDisplay = usernameStr;
    NSLog(@"username %@",usernameDisplay);

}

-(void)setCurrentUserBadge:(NSString*)BadgeStr{
    BadgeDisplay = BadgeStr;

}
    
-(void)setcurrentMojocoins:(NSInteger)MojoStr{
        MojoDisplay = MojoStr;
    
    
    NSLog(@"mojocoins %d",MojoDisplay);

}

-(void)setcurrentxppoints:(NSString*)xppointsStr{
    xppointsDisplay = xppointsStr;
    
    
}
-(void)setUserID_gameID:(NSString *)userID_gameID{
    usrID = userID_gameID;
}

-(void)getActLog
{
    
    //    NSString*SportName = @"Cricket";
    
    //    NSString *bodyData = [NSString stringWithFormat:@"sport=%@&action=getSport",SportName];
    
    NSMutableURLRequest *getRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://gamojo.inclabs.in/api/users.php?uid=%@&action=getActivityLog",usrID]]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [getRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a GET request and specify its body data
    //    [getRequest setHTTPMethod:@"GET"];
    //    [getRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    
    
    NSLog(@"get request is %@",getRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:getRequest delegate:self];
    if(conn){
        getActivity=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"Sport Cricket data is %@",getActivity);
        
    }
}


#pragma mark NSURL Delegates 
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    getActivity = [[NSMutableData alloc] init];
    
    [getActivity setLength:0];
    NSLog(@"response %@",response);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    NSError* error;
    NSDictionary* jsonActivityData = [NSJSONSerialization
                                   JSONObjectWithData:getActivity //1
                                   
                                   options:kNilOptions
                                   error:&error];
    NSLog(@"jsondata %@",jsonActivityData);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)Data {
    // Append the new data to the instance variable you declared
    [getActivity appendData:Data];
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



@end
