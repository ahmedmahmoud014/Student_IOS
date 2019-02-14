//
//  ResultViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/6/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "ResultObj.h"
#import "VSDropdown.h"

@interface ResultViewController : BaseViewController <DataTransferDelegate,UITableViewDataSource,UITableViewDelegate,VSDropdownDelegate>{
    
    UITableView *tableView;
    UIView *controlsView;
    
    ResultObj *myResult;
    
    UIButton * semesterValBtn;
    UILabel * semesterLbl;
    UILabel * cumGradeLbl;
    UILabel * cumGradeValLbl;
    UILabel * semesterGradeLbl;
    UILabel * semesterGradeValLbl;
    
    UILabel * courseLbl;
    UILabel * courseGradeLbl;
    VSDropdown *dropDown;
    SemesterObj * selectedSemesterObj;
}

@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) IBOutlet UIView *controlsView;

@property(nonatomic,retain) IBOutlet UIButton * semesterValBtn;
@property(nonatomic,retain) IBOutlet UILabel * semesterLbl;
@property(nonatomic,retain) IBOutlet UILabel * cumGradeLbl;
@property(nonatomic,retain) IBOutlet UILabel * cumGradeValLbl;
@property(nonatomic,retain) IBOutlet UILabel * semesterGradeLbl;
@property(nonatomic,retain) IBOutlet UILabel * semesterGradeValLbl;

@property(nonatomic,retain) IBOutlet UILabel * courseLbl;
@property(nonatomic,retain) IBOutlet UILabel * courseGradeLbl;

-(IBAction)onSemesterPressed:(id)sender;


@end
