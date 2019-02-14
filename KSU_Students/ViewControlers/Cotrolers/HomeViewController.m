//
//  HomeViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 6/29/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "HomeViewController.h"
#import "StaticVariables.h"
#import "LocalizedMessages.h"
#import "AppDelegate.h"
#import "StaticFuntions.h"



@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize titleLbl;

@synthesize acdTransBtn;
@synthesize acdRecordsBtn;
@synthesize booksBtn;
@synthesize calendarBtn;
@synthesize loansBtn;
@synthesize resultBtn;
@synthesize attendanceBtn;
@synthesize rewardsBtn;
@synthesize scheduleBtn;
@synthesize profileBtn;
@synthesize planBtn;
NSUInteger a;
- (void)viewDidLoad {
    [super viewDidLoad];
   a = [self getCountOfSemester];

    
    
     [self customizeNavigationBar:NO WithMenu:YES];
    
    self.navigationController.interactivePopGestureRecognizer.delegate=nil;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate=nil;
   // self.navigationController.interactivePopGestureRecognizer.enabled=NO;
}
- (NSUInteger)getCountOfSemester {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.studentObj.semestersArr.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - base methods

-(void)initalizeViews{
}

-(void)locatizeLables{
    titleLbl.text=homeTitleText;
    [acdRecordsBtn setTitle:recordTitleText forState:UIControlStateNormal];
    [acdTransBtn setTitle:transactionTitleText forState:UIControlStateNormal];
    [booksBtn setTitle:bookScreenTitle forState:UIControlStateNormal];
    [calendarBtn setTitle:CalenderTitleText forState:UIControlStateNormal];
    [loansBtn setTitle:loansTitleText forState:UIControlStateNormal];
    [resultBtn setTitle:resultTitleText forState:UIControlStateNormal];
    [attendanceBtn setTitle:AttendanceTitleText forState:UIControlStateNormal];
    [rewardsBtn setTitle:rewardsTitleText forState:UIControlStateNormal];
    [scheduleBtn setTitle:scheduleTitleText forState:UIControlStateNormal];
    [profileBtn setTitle:profileTitleText forState:UIControlStateNormal];
    [planBtn setTitle:planTitleText forState:UIControlStateNormal];
}

-(void)switchToLeftLayout{
}

-(void)switchToRightLayout{

}


#pragma  mark - events

-(IBAction)onProfilePressed:(id)sender{
  
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueProfileScreen];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)onRewardsPressed:(id)sender{
    if ( a !=0   )
    {
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueRewardsScreen];
    [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
        [StaticFuntions showAlertWithTitle:@"" Message:StudentNotRegist];
        
    }
}

-(IBAction)onTransactionsPressed:(id)sender{
    if ( a !=0   )
    {
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueTransactionsScreen];
    [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
        [StaticFuntions showAlertWithTitle:@"" Message:StudentNotRegist];
        
    }
}

-(IBAction)onLoansPressed:(id)sender{
    if ( a !=0   )
    {
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueLoansScreen];
    [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
        [StaticFuntions showAlertWithTitle:@"" Message:StudentNotRegist];
        
    }
}

-(IBAction)onSchedulePressed:(id)sender{
    if ( a !=0   )
    {
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueScheduleScreen];
    [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
        [StaticFuntions showAlertWithTitle:@"" Message:StudentNotRegist];

    }
}

-(IBAction)onPlanPressed:(id)sender{
    if ( a !=0   )
    {
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeaguePlanScreen];
    [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
        [StaticFuntions showAlertWithTitle:@"" Message:StudentNotRegist];
        
    }
}

-(IBAction)onResultPressed:(id)sender{
    if ( a !=0   )
    {
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueResultScreen];
    [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
        [StaticFuntions showAlertWithTitle:@"" Message:StudentNotRegist];
        
    }
}
-(IBAction)onAttendancePressed:(id)sender{
    if ( a !=0   )
    {
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueQRScreen];
    [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
        [StaticFuntions showAlertWithTitle:@"" Message:StudentNotRegist];
        
    }
}

-(IBAction)onRecordPressed:(id)sender{
    if ( a !=0   )
    {
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueRecordsScreen];
    [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
        [StaticFuntions showAlertWithTitle:@"" Message:StudentNotRegist];
        
    }
}

-(IBAction)onBooksPressed:(id)sender{
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueBooksScreen];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)onCalendarPressed:(id)sender{
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueCalendarScreen];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
