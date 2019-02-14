//
//  LoansViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 7/30/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "LoansViewController.h"
#import "AppDelegate.h"
#import "StaticFuntions.h"
#import "RequestManager.h"
#import "LoansTableViewCell.h"
#import "LocalizedMessages.h"

@interface LoansViewController ()

@end

@implementation LoansViewController
@synthesize classYearLbl,typeLbl,amountLbl,tableView;
@synthesize controlsView;

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
}

-(void)locatizeLables{
    self.navigationItem.title=loansTitleText;
    classYearLbl.text=loansClassYearText;
    typeLbl.text=loansTypeText;
    amountLbl.text=loansAmountText;
    
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
    [[RequestManager sharedInstance] getStudentLoans:self withStudentId: appDelegate.studentObj.studentId];
    [self showActivityViewer];
}


#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        loansLstArr=(NSMutableArray*)data;
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [tableView reloadData];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"LoansTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"LoansTableViewCell_en";
    else
        CellIdentifier=@"LoansTableViewCell";
    
    LoansTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[LoansTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    LoansObj *obj=[loansLstArr objectAtIndex:(int)indexPath.row];
    [cell initWithLoanObj:obj withRowId:(int)indexPath.row];
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([loansLstArr count]==0){
        noDataLbl.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
    return [loansLstArr count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - refresh

- (void)refresh:(UIRefreshControl *)refreshControl_ {
    noDataLbl.hidden=YES;
    [self connect];
}

@end

