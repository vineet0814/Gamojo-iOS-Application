//
//  BetsViewController.h
//  ScrollView
//
//  Created by Inclabs Intern on 6/11/14.
//
//

#import <UIKit/UIKit.h>

@interface BetsViewController : UIViewController
{
IBOutlet UILabel *betsLabel;
    IBOutlet UILabel *Odds;
   IBOutlet UILabel *Currentvalue;

    IBOutlet UISlider *sliderBet;
}

@property(nonatomic, assign)NSString *betsString;
@property(nonatomic,assign)NSString *oddsStr;
@property (nonatomic,assign) NSString* bid;
@property(nonatomic,assign) NSString *userID;

-(void)setBetsString:(NSString *)str;
-(void)setOddsStr:(NSString *)OddsStr;
-(void)setBid:(NSString *)bid;
-(void)setUserID:(NSString *)userID;
- (IBAction)BetSegmentControl:(id)sender;



- (IBAction)BetDoneButton:(id)sender;


- (IBAction)CurrentSliderValue:(id)sender;



@end


