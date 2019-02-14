//
//  ScheduleViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "FullScheduleObj.h"

@interface ScheduleViewController :  BaseViewController<DataTransferDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableView;
    UIView *controlsView;
    
    FullScheduleObj *mySchedule;
    UISegmentedControl *daySeg;
    
    UILabel * semesterLbl;
    UILabel * semesterLblVal;
}

@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) IBOutlet UIView *controlsView;

@property(nonatomic,retain) IBOutlet UISegmentedControl *daySeg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *daySegmentHeightConstraint;

@property(nonatomic,retain) IBOutlet UILabel * semesterLbl;
@property(nonatomic,retain) IBOutlet UILabel * semesterLblVal;

@property (weak, nonatomic) IBOutlet UIView *currentWeeklyScheduleView;
@property (weak, nonatomic) IBOutlet UILabel *currentWeeklyScheduleLabel;
@property (weak, nonatomic) IBOutlet UIView *othersView;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;

-(IBAction)onDaysChanged:(id)sender;
- (IBAction)currentWeeklyScheduleAction:(UIButton *)sender;
- (IBAction)othersAction:(UIButton *)sender;

@end
