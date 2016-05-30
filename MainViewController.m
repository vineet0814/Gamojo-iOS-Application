//
//  MainViewController.m
//  ScrollView
//
//  Created by Inclabs Intern on 6/11/14.
//
//

#import "MainViewController.h"
#import "BetsViewController.h"
#import "PollsViewController.h"
#import "UserProfileViewController.h"
#import "MatchCentreViewController.h"
#import "DEMONavigationController.h"
#import "DEMOMenuViewController.h"
#import "CommentViewController.h"

@interface MainViewController ()
{
    
    NSMutableArray * DiscArr;
    NSMutableArray * PollArr;
    NSMutableArray * BetArr;
    NSInteger selectedSegment;
    NSString*betQuestion;
    NSString*pollQuestion;
    NSString *currentTable;
    NSMutableArray * MatchesArr;
    UIButton * DiscAddButton;
    UILabel *PollQues;
    NSInteger rowNo;
    NSInteger screenNo;
    NSMutableData *matchData;
    NSMutableDictionary *Matches ;
    NSMutableArray *PastMatches;
    NSMutableDictionary *currentMatch;
    NSMutableArray *UpcomingMatches;
    NSMutableData*pollData;
    NSString* matchID;
   
    NSMutableArray*pollResults;
    NSString* pollID;
    NSMutableData *discData;
    NSMutableArray*userNameDisc;
    NSMutableData*postDiscTopic;
    NSString*discussionTopic;
    NSMutableData*getBetData;
    NSMutableArray *OddsYes;
    NSMutableArray *OddsNo;
    UILabel *Odds;
    UILabel* likeCount;
    UILabel* dislikeCount;
    NSMutableArray*discResult;
    NSMutableArray *likesDisc;
    NSMutableArray * dislikeDisc;
    NSInteger btnAccLab;
    NSMutableData *postVote;
    NSString *alertBtnTitle;
    NSMutableArray*betResults;
}

@end

@implementation MainViewController
@synthesize imageArray;
@synthesize ascending;
static     NSString *usrID;
static  NSInteger pollArrID ;
static     NSInteger vote;


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
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"UserProfile" style:UIBarButtonItemStylePlain target:self action:@selector(UserPF:)];
    DiscArr = [[NSMutableArray alloc] init];
    PollArr = [[NSMutableArray alloc] init];
    BetArr = [[NSMutableArray alloc] init] ;
    userNameDisc = [[NSMutableArray alloc] init];
    OddsYes = [[NSMutableArray alloc   ] init];
    OddsNo = [[NSMutableArray alloc ]init];
    likesDisc = [[NSMutableArray alloc ]init];
    dislikeDisc = [[NSMutableArray alloc ]init];
betResults = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view from its nib.
    //    secArr= [[NSArray alloc] initWithObjects:@"TODAY",@"TOMORROW",@"UPCOMING",nil];

    currentTable=@"tableDisplay";
    selectedSegment = 0 ;
    imageArray = [[NSArray alloc] initWithObjects:@"photo1.png",@"photo2.png",@"photo3.png", @"photo4.png", @"photo5.png", nil];
    
    
   
    if (selectedSegment == 0 ) {
        
        DiscAddButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 508, 40, 40)];
        [DiscAddButton setTitle:@"+" forState:UIControlStateNormal];
        [DiscAddButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [DiscAddButton addTarget:self action:@selector(DiscAdd:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:DiscAddButton];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:(DEMONavigationController *)self.navigationController
                                                                             action:@selector(showMenu)];
    
    [self getSport];
    
 
    
}



#pragma mark delegate methods (mandatory) for table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    int sec=0;
    if (tableView==tableDisplay) {
        sec= 1;
    }
    if(tableView == scoreTable){
        sec=1;
        
    }
    return sec;
}


-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    int Count =0;
    if(table == scoreTable){
        Count = 1;
        
    }
    if(table == tableDisplay){
    
    
    
    if(selectedSegment==0){
        Count = [DiscArr count];
    }
    
    if(selectedSegment==1){
        Count = [PollArr count];
        
    }
    
    if(selectedSegment==2){
        Count = [BetArr count];
        
    }
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
   
    
    
    
    if (selectedSegment==0){
        if(([DiscArr count] > 0) && ([userNameDisc count] >0) && ([likesDisc count]>0) && ([dislikeDisc count] > 0)){
        
        if(tableView == tableDisplay){
        //cell.textLabel.text=[rowArr objectAtIndex:indexPath.row];
        UIView *ContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
            

            
            
            UILabel *DiscussionQues = [[UILabel alloc] initWithFrame:CGRectMake(10, 30 , 235 , 40)];
            DiscussionQues.numberOfLines = 3 ;
            [DiscussionQues setFont:[UIFont fontWithName:@"Arial" size:14]];
            DiscussionQues.text = [DiscArr objectAtIndex:indexPath.row];
            UILabel *UserName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 15)];
            [UserName setFont:[UIFont fontWithName:@"Arial" size:14]];
            UserName.text = [userNameDisc objectAtIndex:indexPath.row];
            UserName.textColor = [UIColor blueColor];
            
//            UIImage *likeImage = [UIImage imageNamed:@"like.png"];
//            UIImage *dislikeImage = [UIImage imageNamed:@"dislike.png"];
            
            
            UIButton *buttonLike = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [buttonLike addTarget:self
                       action:@selector(LikeBtn:)
             forControlEvents:UIControlEventTouchUpInside];
            [buttonLike setTitle:@"+" forState:UIControlStateNormal];
            buttonLike.frame = CGRectMake(170.0, 50.0, 20.0, 30.0);
            [buttonLike setAccessibilityValue:[NSString stringWithFormat:@"%d",indexPath.row]];
            likeCount = [[UILabel alloc] initWithFrame:CGRectMake(195, 50, 20, 30)];
            [likeCount setFont:[UIFont fontWithName:@"Arial" size:14]];
            
            dislikeCount = [[UILabel alloc] initWithFrame:CGRectMake(250, 50, 20, 30)];
            [dislikeCount setFont:[UIFont fontWithName:@"Arial" size:14]];
            likeCount.text = [NSString stringWithFormat:@"(%@)",[likesDisc objectAtIndex:indexPath.row]];
            dislikeCount.text = [NSString stringWithFormat:@"(%@)",[dislikeDisc objectAtIndex:indexPath.row]];
//          likeCount.text = [discResult objectAtIndex:indexPath.row];
//            dislikeCount.text = [discResult objectAtIndex:indexPath.row];
            
            
            
            UIButton *buttonDisLike = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [buttonDisLike addTarget:self
                           action:@selector(DisLikeBtn:)
                 forControlEvents:UIControlEventTouchUpInside];
            [buttonDisLike setTitle:@"-" forState:UIControlStateNormal];
            [buttonDisLike setAccessibilityValue:[NSString stringWithFormat:@"%d",indexPath.row]];

            buttonDisLike.frame = CGRectMake(230.0, 50.0, 20.0, 30.0);
            
            
            UIView *TapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
            //TapView.tag = i ;
            [TapView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [tap setNumberOfTapsRequired:1];
            [tap setAccessibilityValue:[NSString stringWithFormat:@"%d",indexPath.row]];
            [TapView addGestureRecognizer: tap];

            
            
            [ContentView addSubview:TapView];
            [ContentView  addSubview:likeCount];
            [ContentView addSubview:dislikeCount];
            [ContentView addSubview:buttonDisLike];
            [ContentView addSubview:buttonLike];
            [ContentView addSubview:UserName];
            [ContentView addSubview:DiscussionQues];
            
            
            [cell addSubview:ContentView];
            
    }
       
        }

      
     
        
        
    }
    if(selectedSegment==1){
        if([PollArr count] > 0){
        if(tableView == tableDisplay){
            //cell.textLabel.text=[rowArr objectAtIndex:indexPath.row];
            ContentViewPolls = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
            
            PollQues = [[UILabel alloc] initWithFrame:CGRectMake(10, 30 , 320 , 25)];
            PollQues.text = [PollArr objectAtIndex:indexPath.row];
            [ContentViewPolls addSubview:PollQues];
            [cell addSubview:ContentViewPolls];
            
            
            UIView *TapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
            //TapView.tag = i ;
            [TapView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [tap setNumberOfTapsRequired:1];
            [tap setAccessibilityValue:[NSString stringWithFormat:@"%d",indexPath.row]];
            [TapView addGestureRecognizer: tap];
            
            
            [ContentViewPolls addSubview:TapView];
            
            ContentViewPolls.tag = indexPath.row;
            
            
            
            
        }
        }
    }
    if(selectedSegment==2){
        if(([BetArr count] > 0)){
        if(tableView == tableDisplay){
            
            //cell.textLabel.text=[rowArr objectAtIndex:indexPath.row];
            ContentViewBets = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
            
            UILabel *BetQues = [[UILabel alloc] initWithFrame:CGRectMake(10, 25 , 250 , 30)];
            [BetQues setFont:[UIFont fontWithName:@"Arial" size:15]];
            BetQues.text = [BetArr objectAtIndex:indexPath.row];
            Odds = [[UILabel alloc] initWithFrame:CGRectMake(270, 25, 40, 30)];
            [Odds setFont:[UIFont fontWithName:@"Arial" size:15]];
            Odds.text = [NSString stringWithFormat:@"%@ / %@ ",[OddsYes objectAtIndex:indexPath.row],[OddsNo objectAtIndex:indexPath.row]];
            
            
            UIView *TapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
            //TapView.tag = i ;
            [TapView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            [tap setNumberOfTapsRequired:1];
            [tap setAccessibilityValue:[NSString stringWithFormat:@"%d",indexPath.row]];
            [TapView addGestureRecognizer: tap];
            
            
            [ContentViewBets addSubview:TapView];
            
            ContentViewBets.tag = indexPath.row;

            
            
            
            [ContentViewBets addSubview:BetQues];
            [ContentViewBets addSubview:Odds];
            [cell addSubview:ContentViewBets];
            
        }
        }
        
    }
    

    
        if(tableView == scoreTable){
            
            
            
            if(indexPath.row==0){
//                
//                UIScrollView *ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0 , 320, 140)];
                UIView *ContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
                [ContentView setUserInteractionEnabled:YES];
          //      [ScrollView addSubview:ContentView];
            //    [ScrollView setContentSize:ContentView.frame.size];
              //  ScrollView.pagingEnabled = YES;
                //        [RowSelected isEqualToString:[ContentView setAccessibilityLabel:@"1"]];
                
                
                
                
                
                
                
                UIImageView *ImageViewTeamOne = [[UIImageView alloc] initWithFrame:CGRectMake( 5 , 5 , 60 , 60)];
                UIImageView *ImageViewTeamTwo = [[UIImageView alloc] initWithFrame:CGRectMake( 255, 5, 60, 60)];
                
                NSMutableData*datateampicA = [NSMutableData alloc];
                NSMutableData*datateampicB = [NSMutableData alloc];
                datateampicA=[NSData dataWithContentsOfURL:[NSURL URLWithString:[currentMatch objectForKey:@"teamapic"]]];
                datateampicB=[NSData dataWithContentsOfURL:[NSURL URLWithString:[currentMatch objectForKey:@"teambpic"]]];
                
                
                
                
                
                ImageViewTeamOne.image = [UIImage imageWithData:datateampicA];
                ImageViewTeamTwo.image = [UIImage imageWithData:datateampicB];
                
                    
//                    UIView *TapView = [[UIView alloc]initWithFrame:CGRectMake(320, 0, 320, 140)];
//                    //TapView.tag = i ;
//                    [TapView setUserInteractionEnabled:YES];
//                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//                    [tap setAccessibilityLabel:[NSString stringWithFormat:@"%d",i]];
//                    [tap setNumberOfTapsRequired:1];
//                    [TapView addGestureRecognizer: tap];
//                    
                
                    
                    
                    
                    
                    [ContentView addSubview:ImageViewTeamOne];
                    [ContentView addSubview:ImageViewTeamTwo];
                
                    
                    UILabel *TeamOneName = [[UILabel alloc] initWithFrame:CGRectMake( 5, 75 , 120 , 25)];
                    TeamOneName.text = [NSString stringWithFormat:@"%@", [currentMatch objectForKey:@"teamas"]];
                    UILabel *TeamTwoName = [[UILabel alloc]initWithFrame:CGRectMake( 195, 75, 120, 25)];
                    TeamTwoName.textAlignment = NSTextAlignmentRight;
                    TeamTwoName.text = [NSString stringWithFormat:@"%@",[currentMatch objectForKey:@"teambs"]];
                    UILabel *TeamOneScore = [[UILabel alloc] initWithFrame:CGRectMake( 5, 110 , 120 , 25)];
                    TeamOneScore.text = [NSString stringWithFormat:@" %@  %@",[currentMatch objectForKey:@"teamascores"],[currentMatch objectForKey:@"teamaovers"]];
                    UILabel *TeamTwoScore = [[UILabel alloc] initWithFrame:CGRectMake( 195, 110 , 120 , 25)];
                    TeamTwoScore.text = [NSString stringWithFormat:@"%@  %@",[currentMatch objectForKey:@"teambscores"],[currentMatch objectForKey:@"teambovers"] ];
                    UILabel *VS = [[UILabel alloc] initWithFrame:CGRectMake(150, 20 , 60 , 40)];
                    VS.text = @"VS";
                    
                    
                    
                    
                    [ContentView addSubview:TeamOneName];
                    [ContentView addSubview:TeamTwoName];
                    [ContentView addSubview:TeamOneScore];
                    [ContentView addSubview:TeamTwoScore];
                    [ContentView addSubview:VS];
                
                
                
                [cell addSubview:ContentView];
                
                
                
            
            }
        }
        
        
    
    
    
    
    
    return cell;
}
-(void)LikeBtn:(UIButton*)button{
    
    
    btnAccLab = [button.accessibilityValue integerValue];
    NSLog(@"Like Button clicked %d" ,btnAccLab);
    vote = 1;
    [self postVote];
    //[tableDisplay reloadData];
    
}

-(void)DisLikeBtn:(UIButton*)button{
   btnAccLab = [button.accessibilityValue integerValue];
    NSLog(@"disLike Button clicked %d" ,btnAccLab);
    vote =0;
    [self postVote];
   // [tableDisplay reloadData];
}




//#pragma mark opening a new controller when cell is tapped
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(selectedSegment==2){
//        
//        betQuestion = [BetArr objectAtIndex:indexPath.row];
//        
//        BetsViewController*BetsView = [[BetsViewController alloc] initWithNibName:@"BetsViewController" bundle:nil];
//        
//        [BetsView setBetsString:betQuestion];
//        [self.navigationController pushViewController:
//         BetsView animated:NO];
//
//        
//    }
//    if(selectedSegment==1){
//        pollQuestion = [PollArr objectAtIndex:indexPath.row];
//        PollsViewController*PollsView = [[PollsViewController alloc] initWithNibName:@"PollsViewController" bundle:nil];
//        
//        [PollsView setPollStr:pollQuestion];
//        [self.navigationController pushViewController:
//         PollsView animated:NO];
//    }
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int height =0 ;
    if (tableView == scoreTable) {
        height = 200;
    }
    if (tableView == tableDisplay) {
       
        
        
        
        
        
        
        height = 80;
    }
    return height;
}

#pragma mark segment control button method


- (IBAction)segmentControl:(id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    selectedSegment = segmentedControl.selectedSegmentIndex;
    
    
    if (selectedSegment==0){
        
        DiscAddButton.hidden = NO;
        
        [tableDisplay reloadData];
        



    }
    if(selectedSegment==1){
        DiscAddButton.hidden = YES;

        [tableDisplay reloadData];
    }
    if(selectedSegment==2){
        DiscAddButton.hidden = YES;

        [tableDisplay reloadData];
    }
    
    
    
}


#pragma mark setter getter for match centre values 
-(void)setRowSelected:(NSInteger)rowSelected{

    rowNo = rowSelected;

}

-(void)setScreenNumber:(NSInteger)screenNumber{
    screenNo = screenNumber;
    
}

#pragma mark setter getter method for user id
-(void)setUsrStr:(NSString *)usrStr{
    usrID = usrStr;
    NSLog(@"userID in main view controller%@",usrID);
}

//
//- (IBAction)UserPF:(id)sender {
//    
//    
//    UserProfileViewController*UserProfileView = [[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:
//     UserProfileView animated:NO];
//    
//    
//    
//}





#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    

}

-(IBAction)DiscAdd:(id)sender{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Discussion" message:@"Write a comment ! " delegate:self  cancelButtonTitle:@"Done" otherButtonTitles:@"Cancel",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert setTag:1];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if(alertView.tag==1){
        
    if([[[alertView textFieldAtIndex:0] text] length] > 0){
    
    
    NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
        discussionTopic = [[alertView textFieldAtIndex:0] text];
        [self postDiscTopic];
//        [self getDiscussions];
    }
//    [tableDisplay reloadData];
    }
    if(alertView.tag ==2){
      
    }
}


-(void) handleTap:(UITapGestureRecognizer *)recognizer {
    if(selectedSegment==1){
        if([PollArr count] >0){
        
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        PollsViewController*PollsView = [[PollsViewController alloc] initWithNibName:@"PollsViewController" bundle:nil];
        [PollsView setPollStr:[PollArr objectAtIndex:[recognizer.accessibilityValue integerValue]]];
        [self.navigationController pushViewController:PollsView animated:NO];
        NSLog(@" tag value %d",[recognizer.accessibilityValue integerValue]);
        pollArrID = [recognizer.accessibilityValue integerValue];
        NSMutableArray*pollOptions = [[NSMutableArray alloc]init];
        [pollOptions removeAllObjects];
        pollOptions = [[pollResults objectAtIndex:pollArrID] objectForKey:@"options"];
        NSLog(@" Poll Options%@",pollOptions);
        NSString*optionA = [[pollOptions objectAtIndex:0] objectForKey:@"polloption"];
        NSString*optionB = [[pollOptions objectAtIndex:1] objectForKey:@"polloption"];
        NSString* pollOptionAID = [[pollOptions objectAtIndex:0] objectForKey:@"id"];
        NSString* pollOptionBID = [[pollOptions objectAtIndex:1] objectForKey:@"id"];

        pollID = [[pollResults objectAtIndex:pollArrID] objectForKey:@"id"];
        NSLog(@"the poll Id of the selected poll %@", pollID);
        NSLog(@" option id of A %@",pollOptionAID);
        NSLog(@"option id of B %@",pollOptionBID);
        [PollsView setPollid:pollID];
        [PollsView setPollOptIDA:pollOptionAID];
        [PollsView setPollOptIDB:pollOptionBID];
        [PollsView setOptionA:optionA];
        [PollsView setOptionB:optionB];
        
    }

    }
    }
    if(selectedSegment ==2){
        if([BetArr count] > 0){
        if (recognizer.state == UIGestureRecognizerStateEnded) {
            BetsViewController*BetsView = [[BetsViewController alloc] initWithNibName:@"BetsViewController" bundle:nil];
            [BetsView setBetsString:[BetArr objectAtIndex:[recognizer.accessibilityValue integerValue]]];
            NSLog(@" tag value %d",[recognizer.accessibilityValue integerValue]);
            [BetsView setBid:[[betResults objectAtIndex:[recognizer.accessibilityValue integerValue]] objectForKey:@"id"]];
            [BetsView setOddsStr:Odds.text];
            
            [self.navigationController pushViewController:BetsView animated:NO];

        }
        }
    
    }


    
    if(selectedSegment ==0){
        if([DiscArr count] > 0){
            if (recognizer.state == UIGestureRecognizerStateEnded) {
                CommentViewController*CommentView = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
                [CommentView setCommentTpc:[DiscArr objectAtIndex:[recognizer.accessibilityValue integerValue]]];
                [CommentView setDID:[[discResult objectAtIndex:[recognizer.accessibilityValue integerValue]] objectForKey:@"id"]];
               
                
                
                
                
                [self.navigationController pushViewController:CommentView animated:NO];
                
                NSLog(@" tag value %d",[recognizer.accessibilityValue integerValue]);
                
//                [BetsView setOddsStr:Odds.text];
            }
        }
        
    }

    
    
    

}


#pragma mark get method 
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
    conn.accessibilityLabel=@"matchData";
    if(conn){
        matchData=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"Sport Cricket data is %@",matchData);
        
    }
}

-(void)getPoll{
    
    NSMutableURLRequest *getRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://gamojo.inclabs.in/api/polls.php?matchId=%@&uid=%@&action=getMatchPolls",[currentMatch objectForKey:@"mid"],usrID]]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [getRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a GET request and specify its body data
    //    [getRequest setHTTPMethod:@"GET"];
    //    [getRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    
    
    NSLog(@"get request is %@",getRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:getRequest delegate:self];
    conn.accessibilityLabel=@"polData";
    if(conn){
        pollData=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"Poll data is %@",pollData);
        
    }



}

-(void)getDiscussions{

    NSMutableURLRequest *getRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://gamojo.inclabs.in/api/disc.php?matchId=%@&action=getMatchDisc",[currentMatch objectForKey:@"mid"]]]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [getRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a GET request and specify its body data
    //    [getRequest setHTTPMethod:@"GET"];
    //    [getRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    
    
    NSLog(@"get request is %@",getRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:getRequest delegate:self];
    conn.accessibilityLabel=@"discData";
    if(conn){
        discData=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"Discussion Data data is %@",discData);
        
    }
    
    


}

-(void)getBets{
    
    
    NSLog(@"xxxxxx %@ %@ ",usrID,[currentMatch objectForKey:@"mid"]);
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://gamojo.inclabs.in/api/bets.php?uid=%@&matchId=%@&action=getMatchBets",usrID,[currentMatch objectForKey:@"mid"]]]];
    // Set the request's content type to application/x-www-form-urlencoded
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
  
    
    NSLog(@"request is %@",postRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
    conn.accessibilityLabel =@"getBetsMatch";
    if(conn){
        getBetData=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"data %@",getBetData);
    }
    
    
    

    
}

-(void)postDiscTopic{
    
    NSString *bodyData = [NSString stringWithFormat:@"topic=%@&uid=%@&mid=%@&action=addDisc",discussionTopic,usrID,[currentMatch objectForKey:@"mid"]];
    NSLog(@"xxxxxx %@ %@ ",usrID,[currentMatch objectForKey:@"mid"]);
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://gamojo.inclabs.in/api/disc.php"]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    
    
    NSLog(@"request is %@",postRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
    conn.accessibilityLabel =@"postDisc";
    if(conn){
        postDiscTopic=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"data %@",postDiscTopic);
    }
    

    
}



-(void)postVote{
    
    NSString *bodyData = [NSString stringWithFormat:@"type=topic&uid=%@&did=%@&vote=%d&action=addvote",usrID,[[discResult objectAtIndex:btnAccLab] objectForKey:@"id"],vote];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://gamojo.inclabs.in/api/disc.php"]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    
    
    NSLog(@"request is %@",postRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
    conn.accessibilityLabel =@"postVotes";
    if(conn){
        postVote=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"data %@",postVote);
    }
    
    
    
}






#pragma mark NSURL DELEGATES
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if ([connection.accessibilityLabel isEqualToString:@"matchData"]){
        //matchData = [[NSMutableData alloc] init];
        [matchData setLength:0];
    } if ([connection.accessibilityLabel isEqualToString:@"polData"]){
        //pollData = [[NSMutableData alloc]init];
        [pollData setLength:0];
    }
    if([connection.accessibilityLabel isEqualToString:@"discData"]){
        //discData = [[NSMutableData alloc] init];
        [discData setLength:0];
    }
    if([connection.accessibilityLabel isEqualToString:@"postDisc"])
    {
        //postDiscTopic = [[NSMutableData alloc]init];
        [postDiscTopic setLength:0];
    }
    if([connection.accessibilityLabel isEqualToString:@"getBetsMatch"]){
        //getBetData = [[NSMutableData alloc] init];
        [getBetData setLength:0];
    }
    if([connection.accessibilityLabel isEqualToString:@"postVotes"]){
        //postVote = [[NSMutableData alloc] init];
        [postVote setLength:0];
    }
    
    NSLog(@"response %@",response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)Data {
    // Append the new data to the instance variable you declared
    
    if ([connection.accessibilityLabel isEqualToString:@"matchData"]){
        [matchData appendData:Data];

    }
    if ([connection.accessibilityLabel isEqualToString:@"polData"]){
        [pollData appendData:Data];

    }
    if([connection.accessibilityLabel isEqualToString:@"discData"]){
        [discData appendData:Data];

    }
    if([connection.accessibilityLabel isEqualToString:@"postDisc"])
    {
        [postDiscTopic appendData:Data];

    }
    if([connection.accessibilityLabel isEqualToString:@"getBetsMatch"]){
        [getBetData appendData:Data];

    }
    if([connection.accessibilityLabel isEqualToString:@"postVotes"]){
        [postVote appendData:Data];
 
    }

    
    
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


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    if([connection.accessibilityLabel isEqualToString:@"matchData"]){
        [PastMatches removeAllObjects];
        [UpcomingMatches removeAllObjects];
        [currentMatch removeAllObjects];
        NSError* error;
        NSDictionary* jsonMatchData = [NSJSONSerialization
                                       JSONObjectWithData:matchData //1
                                       
                                       options:kNilOptions
                                       error:&error];
        NSLog(@"jsondata in main view controller %@",jsonMatchData);
        
        Matches = [jsonMatchData objectForKey:@"matches"];
        if(rowNo ==2){
            PastMatches = [Matches objectForKey:@"past"];
            currentMatch = [PastMatches objectAtIndex:screenNo];
            NSLog(@"Current match selected details %@",currentMatch);
            matchID = [currentMatch objectForKey:@"matchfeedid"];
            
            
        }
        if(rowNo ==1){
            UpcomingMatches = [Matches objectForKey:@"upcoming"];
            currentMatch = [UpcomingMatches objectAtIndex:screenNo];
            NSLog(@"Current match selected is from upcoming sction %@",currentMatch);
            matchID = [currentMatch objectForKey:@"matchfeedid"];

        }
        
        
        [scoreTable reloadData];
        [self getBets];
        [self getPoll];
       

    }
    
    
    if([connection.accessibilityLabel isEqualToString:@"polData"]){
        
        NSError* error;
        
        NSDictionary* jsonPollData = [NSJSONSerialization
                                      JSONObjectWithData:pollData //1
                                      
                                      options:kNilOptions
                                      error:&error];
        NSLog(@"jsonpolldata in main view controller %@",jsonPollData);
        pollResults = [jsonPollData objectForKey:@"result"];
        NSLog(@" yyyyyyyy %@",pollResults);
        for(int i = 0 ; i < [pollResults count];i++){
            [PollArr addObject:[[pollResults objectAtIndex:i] objectForKey:@"poll"]];
        
        }
        NSMutableArray*pollOptions = [[NSMutableArray alloc]init];
        [pollOptions removeAllObjects];
        pollOptions = [[pollResults objectAtIndex:pollArrID] objectForKey:@"options"];
        NSLog(@" Poll Options%@",pollOptions);
        
     [self getDiscussions];

    
        [tableDisplay reloadData];

       

    }
    
    if([connection.accessibilityLabel isEqualToString:@"getBetsMatch"]){
        NSError* error;
        
        NSDictionary* jsonBetGetData = [NSJSONSerialization
                                         JSONObjectWithData:getBetData //1
                                         
                                         options:kNilOptions
                                         error:&error];
        NSLog(@"get Bets in main view controller %@",jsonBetGetData);
//        NSMutableArray*betResults = [[NSMutableArray alloc]init];
        [betResults removeAllObjects];
        betResults = [jsonBetGetData objectForKey:@"result"];
        for(int i = 0 ; i < [betResults count];i++){
            [BetArr addObject:[[betResults objectAtIndex:i] objectForKey:@"bet"]];
            [OddsNo addObject:[[betResults objectAtIndex:i] objectForKey:@"oddsNo"]];
            [OddsYes addObject:[[betResults objectAtIndex:i] objectForKey:@"oddsYes"]];
        }

        
        [tableDisplay reloadData];
   
    }
    

    
    
    if([connection.accessibilityLabel isEqualToString:@"discData"]){
        NSError* error;
        
        NSDictionary* jsonDiscData = [NSJSONSerialization
                                      JSONObjectWithData:discData //1
                                      
                                      options:kNilOptions
                                      error:&error];
       NSLog(@"jsonDiscdata in main view controller %@",jsonDiscData);
        discResult = [[NSMutableArray alloc] init];
        [discResult removeAllObjects];
        discResult = [jsonDiscData objectForKey:@"result"];
        [DiscArr removeAllObjects];
        [likesDisc removeAllObjects];
        [dislikeDisc removeAllObjects];
        for(int i =0 ; i < [discResult count];i++){
            [DiscArr addObject:[[discResult objectAtIndex:i] objectForKey:@"topic"] ];
            [userNameDisc addObject:[[discResult objectAtIndex:i] objectForKey:@"name"]];
            [likesDisc addObject:[[discResult objectAtIndex:i] objectForKey:@"likes" ]];
            [dislikeDisc addObject:[[discResult objectAtIndex:i] objectForKey:@"dislikes" ]];

        }
        NSLog(@"the like count array is %@", likesDisc);
        [tableDisplay reloadData];

        

    }
    if([connection.accessibilityLabel isEqualToString:@"postDisc"]){
        NSError* error;
        
        NSDictionary* jsonDiscPostData = [NSJSONSerialization
                                      JSONObjectWithData:postDiscTopic //1
                                      
                                      options:kNilOptions
                                      error:&error];
        NSLog(@"posted discussion topic is in main view controller %@",jsonDiscPostData);
        if([[jsonDiscPostData objectForKey:@"message"] isEqualToString:@"Topic placed Succesfully!" ]){
        [self getDiscussions];
        }
//        [tableDisplay reloadData];

    }
    
    
    if([connection.accessibilityLabel isEqualToString:@"postVotes"]){
        NSError* error;
        
        NSDictionary* jsonpostVoteData = [NSJSONSerialization
                                          JSONObjectWithData:postVote //1
                                          
                                          options:kNilOptions
                                          error:&error];
        NSLog(@"posted vote is in main view controller %@",jsonpostVoteData);
        if([[jsonpostVoteData objectForKey:@"message"] isEqualToString:@"Succesfully posted Topic vote"]){
            [self getDiscussions];
            
        }
        if([[jsonpostVoteData objectForKey:@"message"] isEqualToString:@"Already voted"]){
            
            UIAlertView * alertvv = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Already Voted!"] message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alertvv setTag:2];
            [alertvv show];
            
   
        }
    
    }

    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}



@end
