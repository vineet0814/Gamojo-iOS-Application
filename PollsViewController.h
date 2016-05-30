//
//  PollsViewController.h
//  ScrollView
//
//  Created by Inclabs Intern on 6/11/14.
//
//

#import <UIKit/UIKit.h>

@interface PollsViewController : UIViewController

{
    IBOutlet UILabel *pollsLabel;
     IBOutlet UILabel *optALabel;
     IBOutlet UILabel *optBLabel;
}


@property (nonatomic,assign) NSString*PollStr;
@property(nonatomic,assign) NSString*optionA;
@property(nonatomic,assign) NSString*optionB;
@property(nonatomic,assign) NSString*usrid;
@property(nonatomic,assign) NSString*pollid;
@property(nonatomic,assign) NSString*pollOptIDA;
@property(nonatomic,assign) NSString*pollOptIDB;


-(void)setPollStr:(NSString *)strpoll;
-(void)setOptionA:(NSString *)optionA;
-(void)setOptionB:(NSString *)optionB;
-(void)setUsrid:(NSString *)usrid;
-(void)setPollid:(NSString *)pollid;
-(void)setPollOptIDA:(NSString *)pollOptIDA;
-(void)setPollOptIDB:(NSString *)pollOptIDB;


- (IBAction)backBtn:(id)sender;
- (IBAction)option1:(id)sender;
- (IBAction)option3:(id)sender;
- (IBAction)resultBtn:(id)sender;


@end
