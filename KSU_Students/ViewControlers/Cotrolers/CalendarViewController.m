//
//  CalendarViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/13/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "CalendarViewController.h"
#import "AppDelegate.h"
#import "CalendarTableViewCell.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
   /* if(IS_IPAD){
        int x= (self.view.frame.size.width- tableView.frame.size.width)/2;
        tableView.frame=CGRectMake(x, tableView.frame.origin.y, tableView.frame.size.width, tableView.frame.size.height);
        noDataLbl.frame=CGRectMake(x, noDataLbl.frame.origin.y, noDataLbl.frame.size.width, noDataLbl.frame.size.height);
    }*/
    
    tableView.layoutMargins = UIEdgeInsetsZero;
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
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
    [self getData];
}

-(void)locatizeLables{
    self.navigationItem.title=CalenderTitleText;
    noDataLbl.text=NoDataFoundMsg;
    
}

-(void)switchToLeftLayout{
    
}

-(void)switchToRightLayout{
    
    
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"CalendarTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"CalendarTableViewCell_en";
    else
        CellIdentifier=@"CalendarTableViewCell";
    
    CalendarTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CalendarTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    CalendarObj *cObj=[calenderArr objectAtIndex:(int)indexPath.row];
    [cell initWithCalendarObj:cObj withRowIndex:(int)indexPath.row];
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([calenderArr count]==0){
        noDataLbl.hidden=NO;
        tableView.hidden=true;

        return 0;
    }
    noDataLbl.hidden=YES;
    return [calenderArr count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - methods
-(void)damyData{
    calenderArr=[[NSMutableArray alloc] init];
    CalendarObj *calender0=[[CalendarObj alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==Arabic){
        calender0.event=@"العيد القومي";
    }else
        calender0.event=@"National day Holiday";
    calender0.hijriDate=@"28/11/1435 - 23/4/2014";
    calender0.georgDate=@"30/11/1435 - 25/4/2014";
    [calenderArr addObject:calender0];
    [calenderArr addObject:calender0];
    [calenderArr addObject:calender0];
    [calenderArr addObject:calender0];
    [calenderArr addObject:calender0];
    
}

-(void)getData{
    calenderArr=[CalendarObj getCalendarData:NO];
    [tableView reloadData];
}

@end
