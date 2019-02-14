//
//  PlanViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "PlanViewController.h"
#import "AppDelegate.h"
#import "RequestManager.h"
#import "PlanTableViewCell.h"
#import "StaticFuntions.h"
#import "LocalizedMessages.h"

@interface PlanViewController ()

@end

@implementation PlanViewController
@synthesize controlsView,tableView,coursesSeg;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    /*if(IS_IPAD){
     int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
     controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
     }*/
    tableView.layoutMargins = UIEdgeInsetsZero;
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [self initRefreshControl:self.tableView];

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
   // [self connect];
    [self refresh:nil];

    
    myPlan=[[PlanObj alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(appDelegate.currentLang==Arabic){
        coursesSeg.selectedSegmentIndex=2;
    }else{
        coursesSeg.selectedSegmentIndex=0;
    }
    
    UIFont *f= [UIFont boldSystemFontOfSize:14.0];
    
    [coursesSeg setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: f,
                                    NSFontAttributeName,nil]
                          forState:UIControlStateNormal];
}

-(void)locatizeLables{
    self.navigationItem.title=planTitleText;
    
    noDataLbl.text=NoDataFoundMsg;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(appDelegate.currentLang==Arabic){
        [coursesSeg setTitle:planCoursesTakenText forSegmentAtIndex:(int)TakenCourse];
        [coursesSeg setTitle:planCoursesWillTakeText forSegmentAtIndex:(int)WillTakeCourse];
        [coursesSeg setTitle:planCoursesCurrentSemesterText forSegmentAtIndex:(int)CurrentCourse];
    }else{
        [coursesSeg setTitle:planCoursesCurrentSemesterText forSegmentAtIndex:(int)TakenCourse];
        [coursesSeg setTitle:planCoursesWillTakeText forSegmentAtIndex:(int)WillTakeCourse];
        [coursesSeg setTitle:planCoursesTakenText forSegmentAtIndex:(int)CurrentCourse];

    }
}

-(void)switchToLeftLayout{
}

-(void)switchToRightLayout{
    
}

#pragma mark - methods

-(void)connect{
    [refreshControl endRefreshing];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getStudentPlan:self withStudentId: appDelegate.studentObj.studentId];
    [self showActivityViewer];
}

-(int)getSelectedDay{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        if((int)coursesSeg.selectedSegmentIndex==(int)TakenCourse){
            return (int)CurrentCourse;
        }else if((int)coursesSeg.selectedSegmentIndex==(int)WillTakeCourse){
            return (int)WillTakeCourse;
        }else if((int)coursesSeg.selectedSegmentIndex==(int)CurrentCourse){
            return (int)TakenCourse;
        }
    }else{
        return (int)coursesSeg.selectedSegmentIndex;
    }
    return 0;
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        myPlan=(PlanObj*)data;
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [tableView reloadData];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"PlanTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"PlanTableViewCell_en";
    else
        CellIdentifier=@"PlanTableViewCell";
  //  CellIdentifier= [NSString stringWithFormat:@"%@_%ld_%d",CellIdentifier,(long)indexPath.row,[self getSelectedDay] ];
   // NSLog(@"cell id %@",CellIdentifier);
   
    PlanTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       
        cell = [[PlanTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }else{
        cell.courseImg.image=nil;
    }
    CourseObj *obj=nil;
    if ([self getSelectedDay] == (int)TakenCourse) {
        obj=[myPlan.coursesTakenArr objectAtIndex:(int)indexPath.row];
    }else if ([self getSelectedDay]== (int)WillTakeCourse) {
        obj=[myPlan.courseWillBeTakenArr objectAtIndex:(int)indexPath.row];
    }else if ([self getSelectedDay]== (int)CurrentCourse) {
        obj=[myPlan.coursesCurrentArr objectAtIndex:(int)indexPath.row];
    }
    
   // cell.width = 4;
   // cell.xPos = 366;//cell.courseNameLbl.frame.size.width + cell.courseNameLbl.frame.origin.x;
    
    if(appDelegate.currentLang==English){
    
        [cell initWithCourseObj:obj withRowId:(int)indexPath.row withTaken:(!(BOOL)coursesSeg.selectedSegmentIndex)];
    }else{
        [cell initWithCourseObj:obj withRowId:(int)indexPath.row withTaken:((BOOL)coursesSeg.selectedSegmentIndex)];
    }
    
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
 
    [cell setNeedsDisplay];
    [cell setNeedsLayout];
    [cell updateConstraints];

    [self.tableView updateConstraints];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self getSelectedDay] == (int)TakenCourse) {
        if([myPlan.coursesTakenArr count]==0){
            noDataLbl.hidden=NO;
            return 0;
        }
        noDataLbl.hidden=YES;
        return [myPlan.coursesTakenArr count];
    }else if ([self getSelectedDay] == (int)WillTakeCourse) {
        if([myPlan.courseWillBeTakenArr count]==0){
            noDataLbl.hidden=NO;
            return 0;
        }
        noDataLbl.hidden=YES;
        return [myPlan.courseWillBeTakenArr count];
    }else if ([self getSelectedDay] == (int)CurrentCourse) {
        if([myPlan.coursesCurrentArr count]==0){
            noDataLbl.hidden=NO;
            return 0;
        }
        noDataLbl.hidden=YES;
        return [myPlan.coursesCurrentArr count];
    }
    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - events

-(IBAction)onCoursesChanged:(id)sender{
    [tableView reloadData];
}
#pragma mark - refresh

- (void)refresh:(UIRefreshControl *)refreshControl_ {
    noDataLbl.hidden=YES;
    [self connect];
}
@end
