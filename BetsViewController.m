//
//  BetsViewController.m
//  ScrollView
//
//  Created by Inclabs Intern on 6/11/14.
//
//

#import "BetsViewController.h"
#import "MainViewController.h"

@interface BetsViewController ()
{
    NSString *betsTitle;
    NSString *oddsTitle;
    NSInteger selectedSegment;
    NSString* BidID;
    NSMutableData*addBid;
    NSString*bidOption;
    
}
@end
static NSString*usrID;
@implementation BetsViewController

@synthesize betsString;
@synthesize oddsStr;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setBetsString:(NSString *)str
{
    betsTitle=str;
}
-(void)setOddsStr:(NSString *)OddsStr{
    oddsTitle = OddsStr;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    selectedSegment =0;
    betsLabel.text=betsTitle;
    Odds.text = oddsTitle;

}


-(void)setBid:(NSString *)bid{
    BidID = bid;
}

-(void)setUserID:(NSString *)userID{
    usrID = userID;
}



- (IBAction)BetSegmentControl:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    selectedSegment = segmentedControl.selectedSegmentIndex;
    if(selectedSegment ==0){
        bidOption = @"yes";
    }
    if(selectedSegment==1){
    bidOption = @"no";
    }
    
}

- (IBAction)BetDoneButton:(id)sender {
    [self postBid];
}

- (IBAction)CurrentSliderValue:(id)sender {
    
    NSString*currentValueOfSlider = [[NSString alloc]initWithFormat:@"%1.0f",[sliderBet value]];
    [Currentvalue setText:currentValueOfSlider];
}


-(void)postBid{
    
    NSString *bodyData = [NSString stringWithFormat:@"amount=%1.0f&option=%@&uid=%@&bid=%@&action=addBid",[sliderBet value],bidOption,usrID,BidID];
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://gamojo.inclabs.in/api/disc.php"]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    
    
    NSLog(@"request is %@",postRequest);
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
    conn.accessibilityLabel =@"addBid";
    if(conn){
        addBid=[[NSMutableData alloc]initWithCapacity:0];
        NSLog(@"data %@",addBid);
    }
    
    
    
}


#pragma mark NSURL delegates

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if ([connection.accessibilityLabel isEqualToString:@"addBid"]){
        //matchData = [[NSMutableData alloc] init];
        [addBid setLength:0];
    }
    NSLog(@"response %@",response);
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)Data {
    // Append the new data to the instance variable you declared
    
    if ([connection.accessibilityLabel isEqualToString:@"addBid"]){
        [addBid appendData:Data];
        
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
    
    if([connection.accessibilityLabel isEqualToString:@"addBid"]){
        NSError* error;
        NSDictionary* jsonAddBid = [NSJSONSerialization
                                         JSONObjectWithData:addBid //1
                                         
                                         options:kNilOptions
                                         error:&error];
        NSLog(@"Bid added %@",jsonAddBid);
        
    }
    
    
    //    [commentTable reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
