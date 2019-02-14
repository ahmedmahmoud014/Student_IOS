//
//  RewardsViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/27/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface RewardsViewController : BaseViewController<DataTransferDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableView;
    NSMutableArray *rewardsLstArr;
    UILabel *detailsLbl;
    UILabel *dateLbl;
    UILabel *amountLbl;
    UIView *controlsView;
    
}

@property(nonatomic,retain) IBOutlet UITableView *tableView;

@property(nonatomic,retain) IBOutlet UILabel *detailsLbl;
@property(nonatomic,retain) IBOutlet UILabel *dateLbl;
@property(nonatomic,retain) IBOutlet UILabel *amountLbl;
@property(nonatomic,retain) IBOutlet UIView *controlsView;

@end
