//
//  RewardsViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 7/27/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "RewardsViewController.h"
#import "RewardsTableViewCell.h"
#import "RequestManager.h"
#import "AppDelegate.h"
#import "StaticFuntions.h"
#import "LocalizedMessages.h"

@interface RewardsViewController ()

@end

@implementation RewardsViewController
@synthesize tableView,detailsLbl,dateLbl,amountLbl;
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
    //[self connect];
    
     [self refresh:nil];
}

-(void)locatizeLables{
    self.navigationItem.title=rewardsTitleText;
    dateLbl.text=rewardsDateText;
    detailsLbl.text=rewardsDetailsText;
    amountLbl.text=rewardsAmountText;
    
    noDataLbl.text=NoDataFoundMsg;
}

-(void)switchToLeftLayout{
    
    
}

-(void)switchToRightLayout{
    
   /* titleLbl.textAlignment=NSTextAlignmentRight;
    CGRect frame=ticketNoLbl.frame;
    frame.origin.x=0;
    ticketNoLbl.frame=frame;
    
    frame=descrpLbl.frame;
    frame.origin.x=210;
    descrpLbl.frame=frame;*/
}

#pragma mark - methods

-(void)connect{
    [refreshControl endRefreshing];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getStudentRewards:self withStudentId: appDelegate.studentObj.studentId];
    [self showActivityViewer];
}


#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        rewardsLstArr=(NSMutableArray*)data;
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [tableView reloadData];
   // [self updateTable];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"RewardsTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"RewardsTableViewCell_en";
    else
        CellIdentifier=@"RewardsTableViewCell";
    
    RewardsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RewardsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    RewardsObj *obj=[rewardsLstArr objectAtIndex:(int)indexPath.row];
    [cell initWithRewardsObj:obj withRowId:(int)indexPath.row];
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([rewardsLstArr count]==0){
        noDataLbl.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
    return [rewardsLstArr count];
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
