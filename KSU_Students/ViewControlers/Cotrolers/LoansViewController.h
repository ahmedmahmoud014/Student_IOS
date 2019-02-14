//
//  LoansViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/30/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface LoansViewController : BaseViewController<DataTransferDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableView;
    NSMutableArray *loansLstArr;
    UILabel *typeLbl;
    UILabel *amountLbl;
    UILabel *classYearLbl;
    
    UIView *controlsView;
    
}

@property(nonatomic,retain) IBOutlet UITableView *tableView;

@property (nonatomic,retain) IBOutlet UILabel *typeLbl;
@property (nonatomic,retain) IBOutlet UILabel *amountLbl;
@property (nonatomic,retain) IBOutlet UILabel *classYearLbl;

@property(nonatomic,retain) IBOutlet UIView *controlsView;



@end
