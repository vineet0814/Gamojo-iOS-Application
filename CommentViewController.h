//
//  CommentViewController.h
//  ScrollView
//
//  Created by Inclabs Intern on 7/12/14.
//
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController
{
    IBOutlet UITableView *commentTable;
    IBOutlet UILabel *commentTopic;
    
}
@property(nonatomic,assign) NSString* commentTpc;
@property(nonatomic,assign) NSString* userID;
@property(nonatomic,assign) NSString* dID;

-(void)setUserID:(NSString *)userID;
-(void)setDID:(NSString *)dID;
-(void)setCommentTpc:(NSString *)commentTpc;




@end
