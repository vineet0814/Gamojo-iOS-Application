//
//  CommentViewController.m
//  ScrollView
//
//  Created by Inclabs Intern on 7/12/14.
//
//

#import "CommentViewController.h"

@interface CommentViewController ()
{
    NSString* comTopic;
    UIButton* commAddBtn;
    NSString *comment;
    NSString* discID;
    NSMutableData * postComment;
    NSMutableArray *commentArray;
    NSMutableData* discDetails;
    NSMutableArray *usrNameArray;
    NSMutableArray *likesCountArray;
    NSMutableArray *dislikeCountArray;
    NSMutableData* postVote;
    NSInteger vote;
    NSInteger btnAccLab;

}
@end
static     NSString* userid;

@implementation CommentViewController

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
    commentArray = [[NSMutableArray alloc] init];
    usrNameArray = [[NSMutableArray alloc] init];
    likesCountArray = [[NSMutableArray alloc] init];
    dislikeCountArray = [[NSMutableArray alloc] init];
    [usrNameArray removeAllObjects];
    [likesCountArray removeAllObjects];
    [dislikeCountArray removeAllObjects];
    [commentArray removeAllObjects];
    [self getDiscDetails];
    
    // Do any additional setup after loading the view from its nib.
    commentTopic.text = comTopic;
    commAddBtn = [[UIButton alloc] initWithFrame:CGRectMake(140, 518, 40, 40)];
    [commAddBtn setTitle:@"+" forState:UIControlStateNormal];
    [commAddBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [commAddBtn addTarget:self action:@selector(commAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commAddBtn];
    NSLog(@"%@ %@",userid,discID);
}


-(IBAction)commAddBtn:(id)sender{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Discussion" message:@"Write a comment ! " delegate:self  cancelButtonTitle:@"Done" otherButtonTitles:@"Cancel",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert setTag:1];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if(alertView.tag==1){
        
        if([[[alertView textFieldAtIndex:0] text] length] > 0){
            
            
            NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
            comment = [[alertView textFieldAtIndex:0] text];
            [commentTable reloadData];
            [self postComment];
        }
    }
}


-(void)setCommentTpc:(NSString *)commentTpc{
    comTopic = commentTpc;
}

-(void)setUserID:(NSString *)userID{
    userid = userID;
}
-(void)setDID:(NSString *)dID{
    discID = dID;
}


#pragma mark TABLE DELEGATE METHODS
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [commentArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    
    
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    if([commentArray count] > 0){
        UIView *ContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        
        
        
        
        UILabel *DiscussionQues = [[UILabel alloc] initWithFrame:CGRectMake(10, 30 , 235 , 40)];
        DiscussionQues.numberOfLines = 3 ;
        [DiscussionQues setFont:[UIFont fontWithName:@"Arial" size:14]];
        DiscussionQues.text = [commentArray objectAtIndex:indexPath.row];
        UILabel *UserName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 15)];
        [UserName setFont:[UIFont fontWithName:@"Arial" size:14]];
        UserName.text = [usrNameArray objectAtIndex:indexPath.row];
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
        UILabel*likeCount = [[UILabel alloc] initWithFrame:CGRectMake(195, 50, 20, 30)];
        [likeCount setFont:[UIFont fontWithName:@"Arial" size:14]];
        
        UILabel*dislikeCount = [[UILabel alloc] initWithFrame:CGRectMake(250, 50, 20, 30)];
        [dislikeCount setFont:[UIFont fontWithName:@"Arial" size:14]];
        likeCount.text = [NSString stringWithFormat:@"(%@)",[likesCountArray objectAtIndex:indexPath.row]];
        dislikeCount.text = [NSString stringWithFormat:@"(%@)",[dislikeCountArray objectAtIndex:indexPath.row]];
        //          likeCount.text = [discResult objectAtIndex:indexPath.row];
        //            dislikeCount.text = [discResult objectAtIndex:indexPath.row];
        
        
        
        UIButton *buttonDisLike = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonDisLike addTarget:self
                          action:@selector(DisLikeBtn:)
                forControlEvents:UIControlEventTouchUpInside];
        [buttonDisLike setTitle:@"-" forState:UIControlStateNormal];
        [buttonDisLike setAccessibilityValue:[NSString stringWithFormat:@"%d",indexPath.row]];
        
        buttonDisLike.frame = CGRectMake(230.0, 50.0, 20.0, 30.0);
        
        
//        UIView *TapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
//        //TapView.tag = i ;
//        [TapView setUserInteractionEnabled:YES];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
//        [tap setNumberOfTapsRequired:1];
//        [tap setAccessibilityValue:[NSString stringWithFormat:@"%d",indexPath.row]];
//        [TapView addGestureRecognizer: tap];
//        
        
        
//        [ContentView addSubview:TapView];
        [ContentView  addSubview:likeCount];
        [ContentView addSubview:dislikeCount];
        [ContentView addSubview:buttonDisLike];
        [ContentView addSubview:buttonLike];
        [ContentView addSubview:UserName];
        [ContentView addSubview:DiscussionQues];
        
        
        [cell addSubview:ContentView];

    }
    
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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



#pragma mark url 

-(void)postComment{
    
    NSString *bodyData = [NSString stringWithFormat:@"response=%@&uid=%@&did=%@&action=addResponse",comment,userid,discID];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://gamojo.inclabs.in/api/disc.php"]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    
    
    NSLog(@"request is %@",postRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
    conn.accessibilityLabel =@"postComment";
    if(conn){
        postComment=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"data %@",postComment);
    }
    
    
    
}


-(void)getDiscDetails{
    NSMutableURLRequest *getRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://gamojo.inclabs.in/api/disc.php?did=%@&action=getDiscDetails",discID]]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [getRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a GET request and specify its body data
    //    [getRequest setHTTPMethod:@"GET"];
    //    [getRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    
    
    NSLog(@"get request is %@",getRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:getRequest delegate:self];
    conn.accessibilityLabel=@"discDetails";
    if(conn){
        discDetails=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"disc details is %@",discDetails);
        

}
}

-(void)postVote{
    
    NSString *bodyData = [NSString stringWithFormat:@"type=comment&uid=%@&did=%@&vote=%d&action=addvote",userid,discID,vote];
    
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

#pragma mark NSURL delegates

    - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if ([connection.accessibilityLabel isEqualToString:@"postComment"]){
        //matchData = [[NSMutableData alloc] init];
        [postComment setLength:0];
    }
    
    if ([connection.accessibilityLabel isEqualToString:@"discDetails"]){
        //matchData = [[NSMutableData alloc] init];
        [discDetails setLength:0];
    }
    if ([connection.accessibilityLabel isEqualToString:@"postVotes"]){
        //matchData = [[NSMutableData alloc] init];
        [postVote setLength:0];
    }
    

    NSLog(@"response %@",response);


}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)Data {
    // Append the new data to the instance variable you declared
    
    if ([connection.accessibilityLabel isEqualToString:@"postComment"]){
        [postComment appendData:Data];
        
    }
    
    if ([connection.accessibilityLabel isEqualToString:@"discDetails"]){
        [discDetails appendData:Data];
        
    }
    if ([connection.accessibilityLabel isEqualToString:@"postVotes"]){
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
    
    if([connection.accessibilityLabel isEqualToString:@"postComment"]){
        NSError* error;
        NSDictionary* jsonPostComment = [NSJSONSerialization
                                       JSONObjectWithData:postComment //1
                                       
                                       options:kNilOptions
                                       error:&error];
        NSLog(@"jsondata in main view controller %@",jsonPostComment);
        [self getDiscDetails];
 
    }


//    [commentTable reloadData];


    if([connection.accessibilityLabel isEqualToString:@"discDetails"]){
        NSError* error;
        NSDictionary* jsondiscDetails = [NSJSONSerialization
                                         JSONObjectWithData:discDetails //1
                                         
                                         options:kNilOptions
                                         error:&error];
        NSLog(@"jsondata disc details in main view controller %@",jsondiscDetails);
        NSMutableArray*response = [[NSMutableArray alloc] init];
        [response removeAllObjects];
        [commentArray removeAllObjects];
        [likesCountArray removeAllObjects];
        [dislikeCountArray removeAllObjects];
        response = [jsondiscDetails objectForKey:@"responses"];
        for(int i = 0 ; i < [response count];i++){
            [ commentArray addObject:[[response objectAtIndex:i] objectForKey:@"response"]];
            [ usrNameArray addObject:[[response objectAtIndex:i] objectForKey:@"fname"]];
            [ likesCountArray addObject:[[response objectAtIndex:i] objectForKey:@"likes"]];
            [ dislikeCountArray addObject:[[response objectAtIndex:i] objectForKey:@"dislikes"]];

        
        
        }
        [commentTable reloadData];
    }
    
    if([connection.accessibilityLabel isEqualToString:@"postVotes"]){
        NSError* error;
        
        NSDictionary* jsonpostVoteData = [NSJSONSerialization
                                          JSONObjectWithData:postVote //1
                                          
                                          options:kNilOptions
                                          error:&error];
        NSLog(@"posted vote is in main view controller %@",jsonpostVoteData);
        if([[jsonpostVoteData objectForKey:@"message"] isEqualToString:@"Succesfully posted Topic vote"]){
            [self getDiscDetails];
            
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
