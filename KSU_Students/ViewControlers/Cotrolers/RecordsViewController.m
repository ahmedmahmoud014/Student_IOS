//
//  RecordsViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/10/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "RecordsViewController.h"
#import "AppDelegate.h"
#import "RecordTableViewCell.h"
#import "StaticFuntions.h"
#import "RequestManager.h"
#import "RecordObj.h"
#import "LocalizedMessages.h"

@interface RecordsViewController ()

@end

@implementation RecordsViewController
@synthesize tableView,controlsView;
@synthesize gradeLbl,gradeLblVal;

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
   //[self connect];
    
     [self refresh:nil];
}

-(void)locatizeLables{
    self.navigationItem.title=recordTitleText;
    
    noDataLbl.text=NoDataFoundMsg;
}

-(void)switchToLeftLayout{
    
    
}

-(void)switchToRightLayout{
    
}

#pragma mark - methods

-(void)connect{
      [refreshControl endRefreshing];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getStudentRecord:self withStudentId: appDelegate.studentObj.studentId];
    [self showActivityViewer];
}


#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        
        recordsLstArr = (NSMutableArray*)[data objectAtIndex:0];
        gradeLblVal.text = (NSString*)[data objectAtIndex:1];
        
        if ([recordsLstArr count] > 0) {
            gradeLbl.text=recordCumGPAText;
        }
        
        
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [tableView reloadData];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"RecordTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"RecordTableViewCell_en";
    else
        CellIdentifier=@"RecordTableViewCell";
    
    RecordTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RecordTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    RecordObj *objRecord=[recordsLstArr objectAtIndex:(int)indexPath.section];
    CourseObj *obj=[objRecord.coursesArr objectAtIndex:(int)indexPath.row];
    [cell initWithCourseObj:obj withRowId:(int)indexPath.row];
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    RecordObj *objRecord=[recordsLstArr objectAtIndex:(int)section];
    return [objRecord.coursesArr  count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([recordsLstArr count]==0){
        noDataLbl.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
    return [recordsLstArr count];
}

-(UIView*)tableView:(UITableView *)tableView_ viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 3)];
    [view setBackgroundColor:[UIColor clearColor]];
    return view;
}

-(UIView*)tableView:(UITableView *)tableView_ viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    int lable_x=0,semester_x,major_x,lbl_size;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTextAlignment align;
    if(appDelegate.currentLang==English){
        semester_x=5;
        lable_x= self.view.frame.size.width-65;//175;
        major_x=5;
        align=NSTextAlignmentLeft;
    }else{
        semester_x=55;
        lable_x=5;
        major_x=5;
        align=NSTextAlignmentRight;
        
        
    }
    
    lbl_size = self.view.frame.size.width / 3;
    
    
    
    
    
    
    
    
    UILabel *semesterLbl = [[UILabel alloc] initWithFrame:CGRectMake(semester_x, 2, self.view.frame.size.width-60, 25)];
    semesterLbl.textColor=[UIColor whiteColor];
//semesterLbl.font=[semesterLbl.font fontWithSize:16.0];
    semesterLbl.font=[UIFont boldSystemFontOfSize:16.0];
    semesterLbl.textAlignment=align;
    
    
    UILabel *majorLbl = [[UILabel alloc] initWithFrame:CGRectMake(lable_x + lbl_size, 28, (lbl_size * 2) - 9, 25)];
    majorLbl.textColor=[UIColor whiteColor];
    majorLbl.font=[majorLbl.font fontWithSize:14.0];
    majorLbl.textAlignment=align;
    
    
    UILabel *statusLbl = [[UILabel alloc] initWithFrame:CGRectMake(lable_x, 27, 50, 25)];
    statusLbl.textColor=[UIColor whiteColor];
    statusLbl.font=[statusLbl.font fontWithSize :15.0];
    statusLbl.textAlignment=NSTextAlignmentCenter;

    
    
    UILabel *semesterGPALbl = [[UILabel alloc] initWithFrame:CGRectMake(lable_x, 2, lbl_size, 25)];
    semesterGPALbl.textColor=[UIColor whiteColor];
    semesterGPALbl.font = [statusLbl.font fontWithSize :16.0];
    semesterGPALbl.textAlignment=NSTextAlignmentCenter;
    
    
    RecordObj *obj=[recordsLstArr objectAtIndex:section];
    
    [semesterLbl setText:obj.semester.semesterName];
    [majorLbl setText:obj.semester.major];
    [statusLbl setText:obj.semester.status];
    
    semesterGPALbl.text = [NSString stringWithFormat:@"%@ : %@", recordSemesterGPAText,obj.semester.semesterGrade];

    [semesterGPALbl sizeToFit];
    
    
    
    [view addSubview:semesterLbl];
    [view addSubview:majorLbl];
    [view addSubview:statusLbl];
    [view addSubview:semesterGPALbl];

    
    
    if ([obj.semester.semesterId isEqualToString:appDelegate.studentObj.currentSemester.semesterId] ) {
        [view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1]];
    }
    else
    {
        [view setBackgroundColor:[UIColor colorWithRed:75.0/255.0 green:193.0/255.0 blue:239.0/255.0 alpha:1]];
    }
    return view;
    // return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - refresh

- (void)refresh:(UIRefreshControl *)refreshControl_ {
    noDataLbl.hidden=YES;
    [self connect];
}
@end

