//
//  MatchCentreViewController.m
//  ScrollView
//
//  Created by Inclabs Intern on 6/17/14.
//
//

#import "MatchCentreViewController.h"
#import "MainViewController.h"
#import "DEMONavigationController.h"
@interface MatchCentreViewController ()
{
    NSMutableData *SportData;
    NSString *ScreenNumber;
    NSString *SportId;
    NSMutableDictionary *Matches ;
    NSMutableArray *PastMatches;
    NSMutableArray *UpcomingMatches;
    NSMutableArray *LiveMatches;
    NSInteger PastMatchesCount;

    NSMutableArray * PastMatchID;
    UIView *ContentView;
    UIView *ContentViewPast;
    UIView *ContentViewUpcoming;
    NSInteger rowNumber;
    NSInteger LiveMatchesCount;
}

@end

@implementation MatchCentreViewController
@synthesize imageArray;
//@synthesize scrollView;

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
    self.navigationItem.title = @"Match Centre";

    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(DEMONavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
    

  
    
    
    
    imageArray = [[NSArray alloc] initWithObjects:@"photo1.png",@"photo2.png",@"photo3.png", @"photo4.png", @"photo5.png", nil];
    
    [self getSport];

    PastMatchID=[[NSMutableArray alloc] init];
    PastMatches = [[NSMutableArray alloc] init];
    UpcomingMatches = [[NSMutableArray alloc] init];
    LiveMatches = [[NSMutableArray alloc] init];
    

    // Do any additional setup after loading the view from its nib.
}


#pragma mark TABLE DELEGATE METHODS
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    
    
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    if(indexPath.row==0){
        if([LiveMatches count] > 0){
        UIScrollView *ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0 , 320, 168)];
       ContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*[LiveMatches count], 168)];
        [ContentView setUserInteractionEnabled:YES];
        [ScrollView addSubview:ContentView];
        [ScrollView setContentSize:ContentView.frame.size];
        ScrollView.pagingEnabled = YES;
//        [RowSelected isEqualToString:[ContentView setAccessibilityLabel:@"1"]];
        
        for (int i = 0; i < [LiveMatches count]; i++) {
        
            UIImageView *ImageViewTeamOne = [[UIImageView alloc] initWithFrame:CGRectMake(320*i + 5 , 5 , 60 , 60)];
            UIImageView *ImageViewTeamTwo = [[UIImageView alloc] initWithFrame:CGRectMake(320*i + 255, 5, 60, 60)];
            
            NSMutableData*datateampicA = [NSMutableData alloc];
            NSMutableData*datateampicB = [NSMutableData alloc];
            datateampicA=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[LiveMatches objectAtIndex:i]objectForKey:@"teamapic"]]];
            datateampicB=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[LiveMatches objectAtIndex:i]objectForKey:@"teambpic"]]];
            
            
            
            
            
            ImageViewTeamOne.image = [UIImage imageWithData:datateampicA];
            ImageViewTeamTwo.image = [UIImage imageWithData:datateampicB];
            
            
            
            
            UIView *TapView = [[UIView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 168)];
            //TapView.tag = i ;
            [TapView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [tap setAccessibilityLabel:[NSString stringWithFormat:@"%d",i]];
            [tap setNumberOfTapsRequired:1];
            [TapView addGestureRecognizer: tap];
        
            
            
            
            
            
            [ContentView addSubview:ImageViewTeamOne];
            [ContentView addSubview:ImageViewTeamTwo];
            [ContentView addSubview:TapView];
            
            
            UILabel*TeamOneName = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 5, 75 , 120 , 25)];
            TeamOneName.text = [NSString stringWithFormat:@"%@",[[LiveMatches objectAtIndex:i] objectForKey:@"teamas"] ];
            [TeamOneName setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamOneName.numberOfLines = 2;
            TeamOneName.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            
            UILabel*TeamTwoName = [[UILabel alloc]initWithFrame:CGRectMake(320*i + 195, 75, 120, 25)];
            TeamTwoName.textAlignment = NSTextAlignmentRight;
            TeamTwoName.text = [NSString stringWithFormat:@"%@ ",[[LiveMatches objectAtIndex:i]objectForKey:@"teambs"]];
            [TeamTwoName setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamTwoName.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            
            UILabel*TeamOneScore = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 5, 110 , 150 , 25)];
            TeamOneScore.text = [NSString stringWithFormat:@"%@  %@ ",[[LiveMatches objectAtIndex:i]objectForKey:@"teamascores"],[[LiveMatches objectAtIndex:i]objectForKey:@"teamaovers"] ];
            [TeamOneScore setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamOneScore.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            
            UILabel*TeamTwoScore = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 165, 110 , 150 , 25)];
            TeamTwoScore.text = [NSString stringWithFormat:@"%@  %@",[[LiveMatches objectAtIndex:i]objectForKey:@"teambscores"],[[LiveMatches objectAtIndex:i]objectForKey:@"teambovers"] ];
            TeamTwoScore.textAlignment = NSTextAlignmentRight;
            [TeamTwoScore setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamTwoScore.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            
            UILabel *VS = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 150, 40 , 60 , 40)];
            [VS setFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];
            VS.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            VS.text = @"VS";

            UILabel*matchNumber = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 100, 10, 120, 30)];
            matchNumber.text = [[LiveMatches objectAtIndex:i] objectForKey:@"matchnumber"];
            [matchNumber setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            matchNumber.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
            matchNumber.textAlignment = NSTextAlignmentCenter;
            

            UILabel*matchStatus = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 80, 130, 200, 30)];
            matchStatus.text = [[LiveMatches objectAtIndex:i] objectForKey:@"matchstatus"];
            [matchStatus setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            matchStatus.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
            matchStatus.textAlignment = NSTextAlignmentCenter;

            [ContentView addSubview:matchStatus];
            [ContentView addSubview:matchNumber];
            [ContentView addSubview:TeamOneName];
            [ContentView addSubview:TeamTwoName];
            [ContentView addSubview:TeamOneScore];
            [ContentView addSubview:TeamTwoScore];
            [ContentView addSubview:VS];
        }


        [cell addSubview:ScrollView];

        }
        
        if([LiveMatches count] == 0){
            UIView*ContentViewNoLive = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 168)];
            UILabel *Status = [[UILabel alloc] initWithFrame:CGRectMake(80, 73, 280, 30)];
            Status.text = @"Oops ! NO LIVE MATCHES ";
            [Status setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
            Status.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            Status.numberOfLines = 6;
            [ContentViewNoLive addSubview:Status];
            [cell addSubview:ContentViewNoLive];

        }
    }
    
    //////////////////////////////////////////////////////
    
    if(indexPath.row==2){
        
        UIScrollView *ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0 , 320, 168)];
        ContentViewPast = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*[PastMatches count], 168)];
        [ContentViewPast setUserInteractionEnabled:YES];
        [ScrollView addSubview:ContentViewPast];
        [ScrollView setContentSize:ContentViewPast.frame.size];
        ScrollView.pagingEnabled = YES;
        ContentViewPast.tag = indexPath.row;
        
        for (int i = 0; i < [PastMatches count]; i++) {
            
            UIImageView *ImageViewTeamOne = [[UIImageView alloc] initWithFrame:CGRectMake(320*i + 5 , 5 , 60 , 60)];
            UIImageView *ImageViewTeamTwo = [[UIImageView alloc] initWithFrame:CGRectMake(320*i + 255, 5, 60, 60)];
            
            NSMutableData*datateampicA = [NSMutableData alloc];
            NSMutableData*datateampicB = [NSMutableData alloc];
            datateampicA=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[PastMatches objectAtIndex:i]objectForKey:@"teamapic"]]];
            datateampicB=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[PastMatches objectAtIndex:i]objectForKey:@"teambpic"]]];
            
            
            
            
            
            ImageViewTeamOne.image = [UIImage imageWithData:datateampicA];
            ImageViewTeamTwo.image = [UIImage imageWithData:datateampicB];
            
            
            UIView *TapView = [[UIView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 168)];
            [TapView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tapPast = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPast:)];
            [tapPast setAccessibilityLabel:[NSString stringWithFormat:@"%d",i]];

            [tapPast setNumberOfTapsRequired:1];
            [TapView addGestureRecognizer: tapPast];
            
            
            
         
            
            [ContentViewPast addSubview:ImageViewTeamOne];
           [ContentViewPast addSubview:ImageViewTeamTwo];
            [ContentViewPast addSubview:TapView];
            
            
            UILabel*TeamOneName = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 5, 75 , 120 , 25)];
            TeamOneName.text = [NSString stringWithFormat:@"%@",[[PastMatches objectAtIndex:i] objectForKey:@"teamas"] ];
            [TeamOneName setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamOneName.numberOfLines = 2;
            TeamOneName.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            
            
            UILabel*TeamTwoName = [[UILabel alloc]initWithFrame:CGRectMake(320*i + 195, 75, 120, 25)];
            TeamTwoName.textAlignment = NSTextAlignmentRight;
            TeamTwoName.text = [NSString stringWithFormat:@"%@ ",[[PastMatches objectAtIndex:i]objectForKey:@"teambs"]];
            [TeamTwoName setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamTwoName.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            UILabel*TeamOneScore = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 5, 110 , 150 , 25)];
            TeamOneScore.text = [NSString stringWithFormat:@"%@  %@ ",[[PastMatches objectAtIndex:i]objectForKey:@"teamascores"],[[PastMatches objectAtIndex:i]objectForKey:@"teamaovers"] ];
            [TeamOneScore setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamOneScore.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            
            UILabel*TeamTwoScore = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 165, 110 , 150 , 25)];
            TeamTwoScore.text = [NSString stringWithFormat:@"%@  %@",[[PastMatches objectAtIndex:i]objectForKey:@"teambscores"],[[PastMatches objectAtIndex:i]objectForKey:@"teambovers"] ];
            TeamTwoScore.textAlignment = NSTextAlignmentRight;
            [TeamTwoScore setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamTwoScore.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            
            UILabel *VS = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 150, 40 , 60 , 40)];
            [VS setFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];

            VS.text = @"VS";
            VS.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            UILabel* matchNumber = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 100, 10, 120, 30)];
            matchNumber.text = [[PastMatches objectAtIndex:i] objectForKey:@"matchnumber"];
            [matchNumber setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            matchNumber.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
            matchNumber.textAlignment = NSTextAlignmentCenter;

            UILabel*matchStatus = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 20, 130, 300, 30)];
            matchStatus.text = [[PastMatches objectAtIndex:i] objectForKey:@"matchresult"];
            [matchStatus setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            matchStatus.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
            matchStatus.textAlignment = NSTextAlignmentCenter;

            
            [ContentViewPast addSubview:matchStatus];
            [ContentViewPast addSubview:matchNumber];
            [ContentViewPast addSubview:TeamOneName];
            [ContentViewPast addSubview:TeamTwoName];
            [ContentViewPast addSubview:TeamOneScore];
            [ContentViewPast addSubview:TeamTwoScore];
            [ContentViewPast addSubview:VS];
        }
        
        
        [cell addSubview:ScrollView];
        
    }
///////////////////////////////////////////////////////
    
    if(indexPath.row==1){
        UIScrollView *ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0 , 320, 168)];
      ContentViewUpcoming = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*[UpcomingMatches count], 168)];
        [ContentViewUpcoming setUserInteractionEnabled:YES];
        [ScrollView addSubview:ContentViewUpcoming];
        [ScrollView setContentSize:ContentViewUpcoming.frame.size];
        ScrollView.pagingEnabled = YES;
        ContentViewUpcoming.tag = indexPath.row;
        for (int i = 0; i < [UpcomingMatches count]; i++) {
            
            UIImageView *ImageViewTeamOne = [[UIImageView alloc] initWithFrame:CGRectMake(320*i + 5 , 5 , 60 , 60)];
            UIImageView *ImageViewTeamTwo = [[UIImageView alloc] initWithFrame:CGRectMake(320*i + 255, 5, 60, 60)];
            
            NSMutableData*datateampicA = [NSMutableData alloc];
            NSMutableData*datateampicB = [NSMutableData alloc];
            datateampicA=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[UpcomingMatches objectAtIndex:i]objectForKey:@"teamapic"]]];
            datateampicB=[NSData dataWithContentsOfURL:[NSURL URLWithString:[[UpcomingMatches objectAtIndex:i]objectForKey:@"teambpic"]]];

            
            
            
            
            ImageViewTeamOne.image = [UIImage imageWithData:datateampicA];
            ImageViewTeamTwo.image = [UIImage imageWithData:datateampicB];
            
            
            
            UIView *TapView = [[UIView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 168)];
            [TapView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tapUpcoming = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapUpcoming:)];
            [tapUpcoming setNumberOfTapsRequired:1];
            [TapView addGestureRecognizer: tapUpcoming];
            
            
            
            
            
            
            [ContentViewUpcoming addSubview:ImageViewTeamOne];
            [ContentViewUpcoming addSubview:ImageViewTeamTwo];
            [ContentViewUpcoming addSubview:TapView];
            
            
            UILabel*TeamOneName = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 5, 75 , 120 , 25)];
            TeamOneName.text = [NSString stringWithFormat:@"%@",[[UpcomingMatches objectAtIndex:i] objectForKey:@"teamas"] ];
            [TeamOneName setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamOneName.numberOfLines = 2;
            TeamOneName.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            
            UILabel*TeamTwoName = [[UILabel alloc]initWithFrame:CGRectMake(320*i + 195, 75, 120, 25)];
            TeamTwoName.textAlignment = NSTextAlignmentRight;
            TeamTwoName.text = [NSString stringWithFormat:@"%@ ",[[UpcomingMatches objectAtIndex:i]objectForKey:@"teambs"]];
            [TeamTwoName setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamTwoName.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            UILabel*TeamOneScore = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 5, 110 , 150 , 25)];
            TeamOneScore.text = [NSString stringWithFormat:@"%@  %@ ",[[UpcomingMatches objectAtIndex:i]objectForKey:@"teamascores"],[[PastMatches objectAtIndex:i]objectForKey:@"teamaovers"] ];
            [TeamOneScore setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamOneScore.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            
            UILabel*TeamTwoScore = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 165, 110 , 150 , 25)];
            TeamTwoScore.text = [NSString stringWithFormat:@"%@  %@",[[UpcomingMatches objectAtIndex:i]objectForKey:@"teambscores"],[[UpcomingMatches objectAtIndex:i]objectForKey:@"teambovers"] ];
            TeamTwoScore.textAlignment = NSTextAlignmentRight;
            [TeamTwoScore setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
            TeamTwoScore.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];

            
            UILabel *VS = [[UILabel alloc] initWithFrame:CGRectMake(320*i + 150, 40 , 60 , 40)];
            VS.text = @"VS";
            VS.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
            [VS setFont:[UIFont fontWithName:@"HelveticaNeue" size:18]];

            
            
            
            [ContentViewUpcoming addSubview:TeamOneName];
            [ContentViewUpcoming addSubview:TeamTwoName];
            [ContentViewUpcoming addSubview:TeamOneScore];
            [ContentViewUpcoming addSubview:TeamTwoScore];
            [ContentViewUpcoming addSubview:VS];
        }
        

        [cell addSubview:ScrollView];

    }
    
    
    
    return cell;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 168.0;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==0){
        MainViewController*MainView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        
        [self.navigationController pushViewController:MainView animated:NO];
        NSLog(@"Row Number %d",indexPath.row);
        

    }
    if(indexPath.row ==1){
        MainViewController*MainView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        
        [self.navigationController pushViewController:MainView animated:NO];
        NSLog(@"Row Number %d",indexPath.row);
        
    }
    if(indexPath.row ==2){
        MainViewController*MainView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        
        [self.navigationController pushViewController:MainView animated:NO];
        NSLog(@"Row Number %d",indexPath.row);
        
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}


-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
                  MainViewController*MainView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
            
            [self.navigationController pushViewController:MainView animated:NO];
        
        NSLog(@"Screen number %d",[recognizer accessibilityLabel].integerValue);
      
        ScreenNumber = [recognizer accessibilityLabel];
        
        rowNumber = ContentView.tag;
        
    }
}


-(void) handleTapPast:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        MainViewController*MainView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        
        ScreenNumber = [recognizer accessibilityLabel];
        rowNumber = ContentViewPast.tag;
        
        [MainView setRowSelected:rowNumber];
        [MainView setScreenNumber:[recognizer accessibilityLabel].integerValue];
        
        NSLog(@"Screen number %@",[recognizer accessibilityLabel]);
        NSLog(@"row number %d",ContentViewPast.tag);
        [self.navigationController pushViewController:MainView animated:NO];
        
        
    }
}



-(void) handleTapUpcoming:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        MainViewController*MainView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        
        [self.navigationController pushViewController:MainView animated:NO];
        
        NSLog(@"Screen number %d",[recognizer accessibilityLabel].integerValue);
        NSLog(@"row number %d",ContentViewUpcoming.tag);
        ScreenNumber = [recognizer accessibilityLabel];
        rowNumber = ContentViewUpcoming.tag;
        
        [MainView setRowSelected:rowNumber];
        [MainView setScreenNumber:[recognizer accessibilityLabel].integerValue];
    }
}



#pragma mark GET REQUEST ..

-(void)getSport
{

//    NSString*SportName = @"Cricket";

//    NSString *bodyData = [NSString stringWithFormat:@"sport=%@&action=getSport",SportName];

    NSMutableURLRequest *getRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://gamojo.inclabs.in/api/sports.php?sport=Cricket&action=getSport"]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [getRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a GET request and specify its body data
//    [getRequest setHTTPMethod:@"GET"];
//    [getRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    
    
    NSLog(@"get request is %@",getRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:getRequest delegate:self];
    if(conn){
        SportData=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"Sport Cricket data is %@",SportData);
        
    }
}


#pragma mark NSURL DELEGATES
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    SportData = [[NSMutableData alloc] init];
    
    [SportData setLength:0];
    NSLog(@"response %@",response);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [PastMatches removeAllObjects];
    [UpcomingMatches removeAllObjects];
    [LiveMatches removeAllObjects];
    NSError* error;
    NSDictionary* jsonSportData = [NSJSONSerialization
                          JSONObjectWithData:SportData //1
                          
                          options:kNilOptions
                          error:&error];
    NSLog(@"jsondata %@",jsonSportData);
    SportId = [jsonSportData objectForKey:@"id"];
    NSLog(@"Sport Id %@",SportId);
    Matches = [jsonSportData objectForKey:@"matches"];
    NSLog(@"Matches from API %@",Matches);
    PastMatches = [Matches objectForKey:@"past"];
    NSLog(@"%@",PastMatches);
    NSLog(@"Number of past matches %d",[PastMatches count]);
    PastMatchesCount = [PastMatches count];
    for(int p = 0 ; p < [PastMatches count] ; p++){
        [PastMatchID  addObject:[[PastMatches objectAtIndex:p] objectForKey:@"feedmatchid"]];
        NSLog(@"%@ vs %@ ",[[PastMatches objectAtIndex:p] objectForKey:@"teamas"],[[PastMatches objectAtIndex:p]objectForKey:@"teambs"]);
        
    
    }
    
    
    UpcomingMatches = [Matches objectForKey:@"upcoming"];
    
    LiveMatches = [Matches objectForKey:@"live"];
    
    
    [TableViewDisplayMatchCentre reloadData];
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)Data {
    // Append the new data to the instance variable you declared
    [SportData appendData:Data];
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


-(void)getPoll{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
