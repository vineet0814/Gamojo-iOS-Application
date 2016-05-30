//
//  PollsResultViewController.h
//  ScrollView
//
//  Created by Inclabs Intern on 7/10/14.
//
//

#import <UIKit/UIKit.h>

@interface PollsResultViewController : UIViewController
{
    
     IBOutlet UILabel *option1;
     IBOutlet UILabel *opt1percent;
     IBOutlet UILabel *option2;
     IBOutlet UILabel *opt2percent;
}
@property(nonatomic,assign) NSInteger opt1Count;
@property(nonatomic,assign) NSInteger opt2Count;
@property(nonatomic,assign) NSInteger totalCount;
@property(nonatomic,assign) NSString *option1name;
@property(nonatomic,assign) NSString *option2name;

-(void)setOpt1Count:(NSInteger)opt1Count;
-(void)setOpt2Count:(NSInteger)opt2Count;
-(void)setTotalCount:(NSInteger)totalCount;
-(void)setOption1name:(NSString *)option1name;
-(void)setOption2name:(NSString *)option2name;
@end
