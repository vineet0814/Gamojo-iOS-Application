//
//  PollsViewController.m
//  ScrollView
//
//  Created by Inclabs Intern on 6/11/14.
//
//

#import "PollsViewController.h"
#import "MainViewController.h"
#import "PollsResultViewController.h"

@interface PollsViewController ()
{
    NSString*PollTitle;
   NSInteger  count_1;
    NSInteger count_2;
    NSInteger total;
    NSString*optATitle;
    NSString*optBTitle;
    NSMutableData*pollResponseData;
    
    NSString *PollID;
    NSString *OptionIDB;
    NSString* FinalOptID;
    NSString *Message;
    
    UIView *ContentView;

}
@end

@implementation PollsViewController
@synthesize PollStr;

static NSString *usrID;
static NSString *OptionIDA;
static NSString *Message;


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
    pollsLabel.text = PollTitle;

    optALabel.text = optATitle;
    optBLabel.text = optBTitle;
//    [ContentView setHidden:YES];
}
-(void)setPollStr:(NSString *)strpoll{
    PollTitle = strpoll;
}

- (IBAction)backBtn:(id)sender {
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

- (IBAction)option1:(id)sender {
    FinalOptID = OptionIDA;
    
    [self postPollResponse];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
}


- (IBAction)option3:(id)sender {
    FinalOptID = OptionIDB;
    [self postPollResponse];
    
   
}

- (IBAction)resultBtn:(id)sender {
    if([Message length] > 0){
    PollsResultViewController*pollResultView = [[PollsResultViewController alloc] initWithNibName:@"PollsResultViewController" bundle:nil ];
    [self.navigationController pushViewController:pollResultView animated:YES];
    }
}


-(void)setOptionA:(NSString *)optionA{
    
    optATitle = optionA;
    
}


-(void)setOptionB:(NSString *)optionB{
    
    optBTitle = optionB;
    
}

-(void)setUsrid:(NSString *)usrid{
    usrID = usrid;
    NSLog(@"User ID is %@",usrID);
}
-(void)setPollid:(NSString *)pollid{
    PollID = pollid;
}
-(void)setPollOptIDA:(NSString *)pollOptIDA{
    OptionIDA = pollOptIDA;
    NSLog(@"No option ID %@",OptionIDA);

}

-(void)setPollOptIDB:(NSString *)pollOptIDB{
    OptionIDB = pollOptIDB;
}

#pragma mark POST method for adding poll response 
-(void)postPollResponse{
    
    NSString *bodyData = [NSString stringWithFormat:@"uid=%@&pid=%@&poid=%@&action=addPollResponse",usrID,PollID,FinalOptID];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://gamojo.inclabs.in/api/polls.php"]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];

    
    
    NSLog(@"request is %@",postRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
    if(conn){
        pollResponseData=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"data %@",pollResponseData);
    }

    
    
    
    
    
}


#pragma mark NSURL Delegates

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
        pollResponseData = [[NSMutableData alloc] init];
        [pollResponseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)Data {
    // Append the new data to the instance variable you declared
    [pollResponseData appendData:Data];
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
    
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:pollResponseData//1
                          
                          options:kNilOptions
                          error:&error];
    NSLog(@"jsondata post reponse for a poll  %@",json);
    Message = [json objectForKey:@"message"];
    NSLog(@"Message %@",Message);
    
    if([Message length] > 0){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",Message] message:nil delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
        
        
        [alert show];
        

        
    }
    
    NSMutableDictionary* polledResult = [[NSMutableDictionary alloc] init];
    polledResult = [json objectForKey:@"result"];
    NSLog(@"polled result is %@",polledResult);
    NSLog(@"response %@",[polledResult objectForKey:@"responses"]);
    NSMutableArray* response = [polledResult objectForKey:@"responses"];
    count_1 = [[[response objectAtIndex:0] objectForKey:@"count"] integerValue];
    count_2 = [[[response objectAtIndex:1] objectForKey:@"count"] integerValue];
    total = [[polledResult objectForKey:@"total"] integerValue];

    PollsResultViewController*pollsResultView = [[PollsResultViewController alloc]initWithNibName:@"PollsResultViewController" bundle:nil ];

    [pollsResultView setOpt1Count:[[[response objectAtIndex:0] objectForKey:@"count"] integerValue]];
    [pollsResultView setOpt2Count:[[[response objectAtIndex:1] objectForKey:@"count"] integerValue]];
    [pollsResultView setTotalCount:[[polledResult objectForKey:@"total"] integerValue]];
    [pollsResultView setOption1name:[[response objectAtIndex:0] objectForKey:@"name"]];
    [pollsResultView setOption2name:[[response objectAtIndex:1]objectForKey:@"name"]];
    
//    NSMutableArray* responsePolled = [[NSMutableArray alloc] init];
//    [responsePolled removeAllObjects];
//    responsePolled = [[polledResult objectAtIndex:0 ] objectForKey:@"response"];
   NSLog(@"total votes are %d",total);
    NSLog(@"asdafafga %@",[[response objectAtIndex:0] objectForKey:@"name"] );
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
