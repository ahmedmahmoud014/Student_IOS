//
//  ScheduleViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "ScheduleViewController.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "ScheduleTableViewCell.h"
#import "RequestManager.h"

@interface ScheduleViewController () {
    int currentScheduleTab;
}

@end

@implementation ScheduleViewController

@synthesize tableView;
@synthesize controlsView;
@synthesize daySeg, daySegmentHeightConstraint;
@synthesize semesterLbl,semesterLblVal;
@synthesize currentWeeklyScheduleView, currentWeeklyScheduleLabel, othersView, otherLabel;

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    currentScheduleTab = WEEK_SCHEDULE;
    
    [self handleTabSelection];
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

    
    mySchedule=[[FullScheduleObj alloc] init];
  /*  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
   if(appDelegate.currentLang==English){
        daySeg.selectedSegmentIndex=0;
    }else{
        daySeg.selectedSegmentIndex=5;
    }*/
    [self todayFocus];
    
    UIFont *f= [UIFont boldSystemFontOfSize:12.0];

    [daySeg setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: f,
                                    NSFontAttributeName,nil]
                                    forState:UIControlStateNormal];
}

- (void)handleTabSelection {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    switch (currentScheduleTab) {
        case WEEK_SCHEDULE: {
            daySegmentHeightConstraint.constant = 50;
            daySeg.hidden = false;

            if (appDelegate.currentLang != English) {
                // Current Week
                othersView.layer.cornerRadius = othersView.frame.size.height / 2;
                othersView.layer.borderWidth = 1;
                othersView.layer.borderColor = [self getMainColor].CGColor;
                othersView.backgroundColor = [UIColor whiteColor];
                otherLabel.textColor = [UIColor blackColor];
                
                // Others
                currentWeeklyScheduleView.layer.cornerRadius = othersView.frame.size.height / 2;
                currentWeeklyScheduleView.backgroundColor = [UIColor colorWithRed:74.0/255.0 green:193.0/255.0 blue:236.0/255.0 alpha:1];
                currentWeeklyScheduleLabel.textColor = [UIColor whiteColor];

            } else {
                // Current Week
                currentWeeklyScheduleView.layer.cornerRadius = currentWeeklyScheduleView.frame.size.height / 2;
                currentWeeklyScheduleView.layer.borderWidth = 1;
                currentWeeklyScheduleView.layer.borderColor = [UIColor colorWithRed:74.0/255.0 green:193.0/255.0 blue:236.0/255.0 alpha:1].CGColor;
                currentWeeklyScheduleView.backgroundColor = [UIColor whiteColor];
                currentWeeklyScheduleLabel.textColor = [UIColor blackColor];
                
                // Others
                othersView.layer.cornerRadius = othersView.frame.size.height / 2;
                othersView.backgroundColor = [UIColor colorWithRed:74.0/255.0 green:193.0/255.0 blue:236.0/255.0 alpha:1];
                otherLabel.textColor = [UIColor whiteColor];
            }
        }
            break;
        case OTHERS: {
            daySegmentHeightConstraint.constant = 0;
            daySeg.hidden = true;
            
            if (appDelegate.currentLang != English) {
                // Current Week
                currentWeeklyScheduleView.layer.cornerRadius = currentWeeklyScheduleView.frame.size.height / 2;
                currentWeeklyScheduleView.layer.borderWidth = 1;
                currentWeeklyScheduleView.layer.borderColor = [UIColor colorWithRed:74.0/255.0 green:193.0/255.0 blue:236.0/255.0 alpha:1].CGColor;
                currentWeeklyScheduleView.backgroundColor = [UIColor whiteColor];
                currentWeeklyScheduleLabel.textColor = [UIColor blackColor];
                
                // Others
                othersView.layer.cornerRadius = othersView.frame.size.height / 2;
                othersView.backgroundColor = [UIColor colorWithRed:74.0/255.0 green:193.0/255.0 blue:236.0/255.0 alpha:1];
                otherLabel.textColor = [UIColor whiteColor];
            } else {
                // Current Week
                othersView.layer.cornerRadius = othersView.frame.size.height / 2;
                othersView.layer.borderWidth = 1;
                othersView.layer.borderColor = [self getMainColor].CGColor;
                othersView.backgroundColor = [UIColor whiteColor];
                otherLabel.textColor = [UIColor blackColor];
                
                // Others
                currentWeeklyScheduleView.layer.cornerRadius = othersView.frame.size.height / 2;
                currentWeeklyScheduleView.backgroundColor = [UIColor colorWithRed:74.0/255.0 green:193.0/255.0 blue:236.0/255.0 alpha:1];
                currentWeeklyScheduleLabel.textColor = [UIColor whiteColor];
            }
        }
            break;
        default:
            break;
    }
    [tableView reloadData];
}

-(void)locatizeLables{
    self.navigationItem.title=scheduleTitleText;
   
    noDataLbl.text=NoDataFoundMsg;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    semesterLblVal.text=appDelegate.studentObj.currentSemester.semesterName;
    semesterLbl.text=scheduleSemesterText;
    
    if(appDelegate.currentLang!=English){
        //[daySeg setTitle:scheduleSaturdayText forSegmentAtIndex:(int)Saturday];
        /*[daySeg setTitle:scheduleSundayText forSegmentAtIndex:(int)Sunday];
        [daySeg setTitle:scheduleMondayText forSegmentAtIndex:(int)Monday];
        [daySeg setTitle:scheduleTuesdayText forSegmentAtIndex:(int)Tuesday];
        [daySeg setTitle:scheduleWednesdayText forSegmentAtIndex:(int)Wednesday];
        [daySeg setTitle:scheduleThursdayText forSegmentAtIndex:(int)Thursday];*/
        [daySeg setTitle:scheduleThursdayText forSegmentAtIndex:(int)Sunday];
        [daySeg setTitle:scheduleWednesdayText forSegmentAtIndex:(int)Monday];
        [daySeg setTitle:scheduleTuesdayText forSegmentAtIndex:(int)Tuesday];
        [daySeg setTitle:scheduleMondayText forSegmentAtIndex:(int)Wednesday];
        [daySeg setTitle:scheduleSundayText forSegmentAtIndex:(int)Thursday];
        
        [currentWeeklyScheduleLabel setText:WeeklyScheduleText];
        [otherLabel setText:ScheduleOthersText];
    }else{
        
       /* [daySeg setTitle:scheduleThursdayText forSegmentAtIndex:(int)Saturday];
        [daySeg setTitle:scheduleWednesdayText forSegmentAtIndex:(int)Sunday];
        [daySeg setTitle:scheduleTuesdayText forSegmentAtIndex:(int)Monday];
        [daySeg setTitle:scheduleMondayText forSegmentAtIndex:(int)Tuesday];
        [daySeg setTitle:scheduleSundayText forSegmentAtIndex:(int)Wednesday];
        [daySeg setTitle:scheduleSaturdayText forSegmentAtIndex:(int)Thursday];*/
        
        /*[daySeg setTitle:scheduleThursdayText forSegmentAtIndex:(int)Sunday];
        [daySeg setTitle:scheduleWednesdayText forSegmentAtIndex:(int)Monday];
        [daySeg setTitle:scheduleTuesdayText forSegmentAtIndex:(int)Tuesday];
        [daySeg setTitle:scheduleMondayText forSegmentAtIndex:(int)Wednesday];
        [daySeg setTitle:scheduleSundayText forSegmentAtIndex:(int)Thursday];*/
        
        [daySeg setTitle:scheduleSundayText forSegmentAtIndex:(int)Sunday];
        [daySeg setTitle:scheduleMondayText forSegmentAtIndex:(int)Monday];
        [daySeg setTitle:scheduleTuesdayText forSegmentAtIndex:(int)Tuesday];
        [daySeg setTitle:scheduleWednesdayText forSegmentAtIndex:(int)Wednesday];
        [daySeg setTitle:scheduleThursdayText forSegmentAtIndex:(int)Thursday];
        
        [currentWeeklyScheduleLabel setText:ScheduleOthersText];
        [otherLabel setText:WeeklyScheduleText];
    }
    
    currentWeeklyScheduleLabel.font = [UIFont boldSystemFontOfSize:12.0];
    otherLabel.font = [UIFont boldSystemFontOfSize:12.0];
}

-(void)switchToLeftLayout{
    
    daySeg.contentVerticalAlignment=UIControlContentHorizontalAlignmentLeft;
}

-(void)switchToRightLayout{
    daySeg.contentVerticalAlignment=UIControlContentHorizontalAlignmentRight;
    

}

#pragma mark - methods

-(void)todayFocus{
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSLog(@"today = %ld",(long)[components weekday]);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    int today= (int)[components weekday] ;
    if(today==6|| today==7)//friday, saturday
        today=0;
    /*if(appDelegate.currentLang!=English){
        today=today-1;

        daySeg.selectedSegmentIndex=today;
    }else{
        daySeg.selectedSegmentIndex=today;
    }*/
    
    
    if(appDelegate.currentLang==Arabic)
    {
        if (today == 5) {
            today = 1;
        }
        else if (today == 4) {
            today = 2;
        }
        else if (today == 3) {
            today = 3;
        }
        else if (today == 2) {
            today = 4;
        }
        else if (today == 1) {
            today = 5;
        }
        
        today=today-1;
        daySeg.selectedSegmentIndex=today;
    }else{
        today=today-1;
        daySeg.selectedSegmentIndex=today;
    }
    
}

-(void)connect{
    [refreshControl endRefreshing];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getStudentSchedule:self withStudentId: appDelegate.studentObj.studentId];
    [self showActivityViewer];
    [self clearArrays];
}


-(void)clearArrays{
//    mySchedule.saturdayArr=[[NSMutableArray alloc] init];
    mySchedule.sundayArr=[[NSMutableArray alloc] init];
    mySchedule.mondayArr=[[NSMutableArray alloc] init];
    mySchedule.tuesdayArr=[[NSMutableArray alloc] init];
    mySchedule.wednesdayArr=[[NSMutableArray alloc] init];
    mySchedule.thursdayArr=[[NSMutableArray alloc] init];
    mySchedule.othersArr=[[NSMutableArray alloc] init];
}

-(int)getSelectedDay{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    switch (currentScheduleTab) {
        case WEEK_SCHEDULE: {
            if(appDelegate.currentLang==Arabic){
                if((int)daySeg.selectedSegmentIndex==(int)Thursday){
                    return (int)Sunday;
                }else if((int)daySeg.selectedSegmentIndex==(int)Wednesday){
                    return (int)Monday;
                }else if((int)daySeg.selectedSegmentIndex==(int)Tuesday){
                    return (int)Tuesday;
                }else if((int)daySeg.selectedSegmentIndex==(int)Monday){
                    return (int)Wednesday;
                }else if((int)daySeg.selectedSegmentIndex==(int)Sunday){
                    return (int)Thursday;
                }/*else if((int)daySeg.selectedSegmentIndex==(int)Saturday){
                  return (int)Thursday;
                  }*/
            }else{
                return (int)daySeg.selectedSegmentIndex;
            }
            return 0;
        }
            break;
        case OTHERS:
            return -1;
            break;
        default:
            return 0;
            break;
    }
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
         NSMutableArray* arr =(NSMutableArray*)data;
        for(int i=0;i<[arr count];i++){
            ScheduleObj* obj=[arr objectAtIndex:i];
            /*if(obj.day==Saturday){
                if(!mySchedule.saturdayArr){
                    mySchedule.saturdayArr=[[NSMutableArray alloc] init];
                }
                [mySchedule.saturdayArr addObject:obj];
             
             
            }else */
            
           // obj.day = [obj.day integerValue];
            
            
            if([obj.day isEqual: @"1"]){
                if(!mySchedule.sundayArr){
                    mySchedule.sundayArr=[[NSMutableArray alloc] init];
                }
                [mySchedule.sundayArr addObject:obj];
            }else if([obj.day isEqual:@"2"]){
                if(!mySchedule.mondayArr){
                    mySchedule.mondayArr=[[NSMutableArray alloc] init];
                }
                [mySchedule.mondayArr addObject:obj];
            }else if([obj.day isEqual:@"3"] ){
                if(!mySchedule.tuesdayArr){
                    mySchedule.tuesdayArr=[[NSMutableArray alloc] init];
                }
                [mySchedule.tuesdayArr addObject:obj];
            }else if([obj.day isEqual:@"4"] ){
                if(!mySchedule.wednesdayArr){
                    mySchedule.wednesdayArr=[[NSMutableArray alloc] init];
                }
                [mySchedule.wednesdayArr addObject:obj];
            }else if([obj.day isEqual:@"5"] ){
                if(!mySchedule.thursdayArr){
                    mySchedule.thursdayArr=[[NSMutableArray alloc] init];
                }
                [mySchedule.thursdayArr addObject:obj];
            } else {
                // OTHERS
                if(!mySchedule.othersArr){
                    mySchedule.othersArr=[[NSMutableArray alloc] init];
                }
                [mySchedule.othersArr addObject:obj];
            }
        }
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [tableView reloadData];
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"ScheduleTableViewCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"ScheduleTableViewCell_en";
    else
        CellIdentifier=@"ScheduleTableViewCell";
    
    ScheduleTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ScheduleTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    ScheduleObj *obj=nil;
    /*if ([self getSelectedDay] == (int)Saturday) {
        obj=[mySchedule.saturdayArr objectAtIndex:(int)indexPath.row];
    }else */if ([self getSelectedDay] == (int)Sunday && mySchedule.sundayArr.count != 0) {
        obj=[mySchedule.sundayArr objectAtIndex:(int)indexPath.row];
    }else if ([self getSelectedDay] == (int)Monday && mySchedule.mondayArr.count != 0) {
        obj=[mySchedule.mondayArr objectAtIndex:(int)indexPath.row];
    }else if ([self getSelectedDay] == (int)Tuesday && mySchedule.tuesdayArr.count != 0) {
        obj=[mySchedule.tuesdayArr objectAtIndex:(int)indexPath.row];
    }else if ([self getSelectedDay] == (int)Wednesday && mySchedule.wednesdayArr.count != 0) {
        obj=[mySchedule.wednesdayArr objectAtIndex:(int)indexPath.row];
    }else if ([self getSelectedDay] == (int)Thursday && mySchedule.thursdayArr.count != 0) {
        obj=[mySchedule.thursdayArr objectAtIndex:(int)indexPath.row];
    } else if ([self getSelectedDay] == -1 && mySchedule.othersArr.count != 0) {
        // OTHERS
        obj=[mySchedule.othersArr objectAtIndex:(int)indexPath.row];
    }

    [cell initWithScheduleObj:obj withRowId:(int)indexPath.row];
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (currentScheduleTab) {
        case WEEK_SCHEDULE: {
            if ([self getSelectedDay] == (int)Sunday) {
                if([mySchedule.sundayArr count]==0){
                    noDataLbl.hidden=NO;
                    return 0;
                }
                noDataLbl.hidden=YES;
                return [mySchedule.sundayArr count];
            }else if ([self getSelectedDay] == (int)Monday) {
                if([mySchedule.mondayArr count]==0){
                    noDataLbl.hidden=NO;
                    return 0;
                }
                noDataLbl.hidden=YES;
                return [mySchedule.mondayArr count];
            }else if ([self getSelectedDay] == (int)Tuesday) {
                if([mySchedule.tuesdayArr count]==0){
                    noDataLbl.hidden=NO;
                    return 0;
                }
                noDataLbl.hidden=YES;
                return [mySchedule.tuesdayArr count];
            }else if ([self getSelectedDay] == (int)Wednesday) {
                if([mySchedule.wednesdayArr count]==0){
                    noDataLbl.hidden=NO;
                    return 0;
                }
                noDataLbl.hidden=YES;
                return [mySchedule.wednesdayArr count];
            }else if ([self getSelectedDay] == (int)Thursday) {
                if([mySchedule.thursdayArr count]==0){
                    noDataLbl.hidden=NO;
                    return 0;
                }
                noDataLbl.hidden=YES;
                return [mySchedule.thursdayArr count];
            }
            return 0;
        }
            break;
            
        case OTHERS: {
            if([mySchedule.othersArr count]==0){
                noDataLbl.hidden=NO;
                return 0;
            }
            noDataLbl.hidden=YES;
            return [mySchedule.othersArr count];
        }
            break;
            
        default:
            return 0;
            break;
    }
    
     /*if ([self getSelectedDay] == (int)Saturday) {
         if([mySchedule.saturdayArr count]==0){
             noDataLbl.hidden=NO;
             return 0;
         }
         noDataLbl.hidden=YES;
         return [mySchedule.saturdayArr count];
//     }else */
//      if ([self getSelectedDay] == (int)Sunday) {
//         if([mySchedule.sundayArr count]==0){
//             noDataLbl.hidden=NO;
//             return 0;
//         }
//         noDataLbl.hidden=YES;
//         return [mySchedule.sundayArr count];
//     }else if ([self getSelectedDay] == (int)Monday) {
//         if([mySchedule.mondayArr count]==0){
//             noDataLbl.hidden=NO;
//             return 0;
//         }
//         noDataLbl.hidden=YES;
//         return [mySchedule.mondayArr count];
//     }else if ([self getSelectedDay] == (int)Tuesday) {
//         if([mySchedule.tuesdayArr count]==0){
//             noDataLbl.hidden=NO;
//             return 0;
//         }
//         noDataLbl.hidden=YES;
//         return [mySchedule.tuesdayArr count];
//     }else if ([self getSelectedDay] == (int)Wednesday) {
//         if([mySchedule.wednesdayArr count]==0){
//             noDataLbl.hidden=NO;
//             return 0;
//         }
//         noDataLbl.hidden=YES;
//         return [mySchedule.wednesdayArr count];
//     }else if ([self getSelectedDay] == (int)Thursday) {
//         if([mySchedule.thursdayArr count]==0){
//             noDataLbl.hidden=NO;
//             return 0;
//         }
//         noDataLbl.hidden=YES;
//         return [mySchedule.thursdayArr count];
//     }
//    return 0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


#pragma mark - events

-(IBAction)onDaysChanged:(id)sender{
    [tableView reloadData];
}

- (IBAction)currentWeeklyScheduleAction:(UIButton *)sender {
    if (currentScheduleTab == OTHERS) {
        currentScheduleTab = WEEK_SCHEDULE;
        [self handleTabSelection];
        [self todayFocus];
        [tableView reloadData];
    }
}

- (IBAction)othersAction:(UIButton *)sender {
    if (currentScheduleTab == WEEK_SCHEDULE) {
        currentScheduleTab = OTHERS;
        [self handleTabSelection];
        [tableView reloadData];
    }
}

#pragma mark - refresh

- (void)refresh:(UIRefreshControl *)refreshControl_ {
    noDataLbl.hidden=YES;
    [self connect];
}
@end
