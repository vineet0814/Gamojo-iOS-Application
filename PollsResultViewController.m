//
//  PollsResultViewController.m
//  ScrollView
//
//  Created by Inclabs Intern on 7/10/14.
//
//

#import "PollsResultViewController.h"

@interface PollsResultViewController ()
{
  
    
}
@end
static NSString*optionOneName;
static NSInteger optionOneCount;
static NSInteger optionTwoCount;
static NSInteger totalCountOptions;

static NSString*optionTwoname;
@implementation PollsResultViewController

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
    NSString*percent = @"%";
    NSInteger percent1 = optionOneCount / totalCountOptions *100;
    NSInteger percent2 = optionTwoCount / totalCountOptions *100;
    option1.text = optionOneName;
    option2.text = optionTwoname;
    opt1percent.text = [NSString stringWithFormat:@"%d%@",percent1,percent];
    opt2percent.text = [NSString stringWithFormat:@"%d%@",percent2,percent];

    // Do any additional setup after loading the view from its nib.
    NSLog(@"option one is %@",optionOneName);
    NSLog(@"option two is %@",optionTwoname);
    NSLog(@"%d",percent1);
    NSLog(@"%d",percent2);

}


-(void)setOpt1Count:(NSInteger)opt1Count{
    optionOneCount = opt1Count;
}


-(void)setOpt2Count:(NSInteger)opt2Count{
    optionTwoCount = opt2Count;
}


-(void)setTotalCount:(NSInteger)totalCount{
    totalCountOptions = totalCount;
}


-(void)setOption1name:(NSString *)option1name{
    NSLog(@"dadiiiaf %@",option1name);
    optionOneName = option1name;
}


-(void)setOption2name:(NSString *)option2name{
    optionTwoname = option2name;

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
