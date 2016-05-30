//
//  MainViewController.h
//  ScrollView
//
//  Created by Inclabs Intern on 6/11/14.
//
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIScrollViewDelegate>

{
     IBOutlet UITableView *scoreTable;
    IBOutlet UITableView *tableDisplay;
    UIView *ContentViewPolls;
    UIView *ContentViewBets;
}
@property (nonatomic,strong) NSArray*imageArray;
@property (nonatomic,assign) NSInteger rowSelected;
@property (nonatomic,assign) NSInteger screenNumber;
@property (nonatomic,assign) NSString* usrStr;
@property (assign, nonatomic) BOOL ascending;


-(void)setRowSelected:(NSInteger)rowSelected;
-(void)setScreenNumber:(NSInteger)screenNumber;
-(void)setUsrStr:(NSString *)usrStr;

- (IBAction)segmentControl:(id)sender;



@end
