//
//  PlanViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "PlanObj.h"


@interface PlanViewController :  BaseViewController<DataTransferDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableView;
    UIView *controlsView;
    
    PlanObj *myPlan;
    UISegmentedControl *coursesSeg;
    
}

@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) IBOutlet UIView *controlsView;

@property(nonatomic,retain) IBOutlet UISegmentedControl *coursesSeg;

-(IBAction)onCoursesChanged:(id)sender;

@end
