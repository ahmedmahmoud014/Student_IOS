//
//  ResultViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/6/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "ResultViewController.h"
#import "StaticFuntions.h"
#import "ResultTableViewCell.h"
#import "RequestManager.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize tableView,controlsView;
@synthesize semesterGradeLbl,semesterGradeValLbl;
@synthesize semesterLbl,semesterValBtn;
@synthesize cumGradeLbl,cumGradeValLbl;
@synthesize courseGradeLbl,courseLbl;


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
    dropDown = [[VSDropdown alloc]initWithDelegate:self];
    [dropDown setAdoptParentTheme:YES];
    [dropDown setShouldSortItems:NO];
    
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    selectedSemesterObj=appDelegate.studentObj.currentSemester;
    if((!selectedSemesterObj)||([StaticFuntions isStringEmpty: selectedSemesterObj.semesterName ])){
        [semesterValBtn setTitle:@"--" forState:UIControlStateNormal];
        semesterValBtn.enabled=NO;
    }else{
         [self refresh:nil];
        //[self connect:appDelegate.studentObj.currentSemester.semesterId];
        [semesterValBtn setTitle:appDelegate.studentObj.currentSemester.semesterName forState:UIControlStateNormal];
        semesterValBtn.enabled=YES;
    }
}

-(void)locatizeLables{
    self.navigationItem.title=resultTitleText;
    cumGradeLbl.text=resultCumGradeText;
    semesterGradeLbl.text=resultSemesterGradeText;
    semesterLbl.text=resultSemesterText;
    courseLbl.text=resultCourseText;
    courseGradeLbl.text=resultCourseGradeText;
    
    noDataLbl.text=NoDataFoundMsg;
}

-(void)switchToLeftLayout{
    
    
}

-(void)switchToRightLayout{
    
}

#pragma mark - methods

-(void)connect:(NSString*)selectedSemester{
    [refreshControl endRefreshing];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getStudentResult:self withStudentId:appDelegate.studentObj.studentId withSemesterCode:selectedSemester ];
    [self showActivityViewer];
}


#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        myResult=(ResultObj*)data;
        
        [semesterValBtn setTitle:myResult.semester.semesterName forState:UIControlStateNormal];
        cumGradeValLbl.text=myResult.cumGrade;
        semesterGradeValLbl.text=myResult.semester.semesterGrade;
        
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [tableView reloadData];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"ResultTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"ResultTableViewCell_en";
    else
        CellIdentifier=@"ResultTableViewCell";
    
    ResultTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ResultTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    CourseObj *obj=[myResult.coursesArr objectAtIndex:(int)indexPath.row];
    [cell initWithCourseObj:obj withRowId: (int)indexPath.row];
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([myResult.coursesArr count]==0){
        noDataLbl.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
    return [myResult.coursesArr count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - events

-(IBAction)onSemesterPressed:(id)sender{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray * array= [[NSMutableArray alloc] init];
    for (int i=0;i<[appDelegate.studentObj.semestersArr count];i++){
        [array addObject:((SemesterObj*)[appDelegate.studentObj.semestersArr objectAtIndex:i]).semesterName];
    }
    [dropDown setDrodownAnimation:rand()%2];
    [dropDown setAllowMultipleSelection:NO];
    [dropDown setupDropdownForView:(UIButton *)sender];
    [dropDown setSeparatorColor:((UIButton *)sender).titleLabel.textColor];
    [dropDown setBackgroundColor:[UIColor whiteColor]];
    [dropDown setTextColor:[UIColor grayColor]];
    
    [dropDown reloadDropdownWithContents:array andSelectedItems:@[((UIButton *)sender).titleLabel.text]];
        
    
}


#pragma mark - VSDropdown Delegate methods.
- (void)dropdown:(VSDropdown *)dropdown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
    /*UIButton *btn = (UIButton *)dropdown.dropDownView;
    NSString *allSelectedItems = [dropdown.selectedItems componentsJoinedByString:@";"];
    [btn setTitle:allSelectedItems forState:UIControlStateNormal];*/
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    selectedSemesterObj=(SemesterObj*)[appDelegate.studentObj.semestersArr objectAtIndex:index];
    [self connect:selectedSemesterObj.semesterId];
    [semesterValBtn setTitle:selectedSemesterObj.semesterName forState:UIControlStateNormal];
}


- (UIColor *)outlineColorForDropdown:(VSDropdown *)dropdown
{
   // UIButton *btn = (UIButton *)dropdown.dropDownView;
    
    return [UIColor grayColor];
    
}

- (CGFloat)outlineWidthForDropdown:(VSDropdown *)dropdown
{
    return 1.0;
}

- (CGFloat)cornerRadiusForDropdown:(VSDropdown *)dropdown
{
    return 3.0;
}

- (CGFloat)offsetForDropdown:(VSDropdown *)dropdown
{
    return -2.0;
}

-(UIColor *)outlineColor{
    return [UIColor whiteColor];
}
#pragma mark - refresh

- (void)refresh:(UIRefreshControl *)refreshControl_ {
    noDataLbl.hidden=YES;
    [self connect:selectedSemesterObj.semesterId];
}
@end

