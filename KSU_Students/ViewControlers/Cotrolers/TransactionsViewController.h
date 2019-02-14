//
//  TransactionsViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/27/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface TransactionsViewController :  BaseViewController<DataTransferDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableView;
    NSMutableArray *transLstArr;
    UILabel *detailsLbl;
    UILabel *statusLbl;
    UILabel *classNameLbl;
    UIView *controlsView;
    
}

@property(nonatomic,retain) IBOutlet UITableView *tableView;

@property(nonatomic,retain) IBOutlet UILabel *detailsLbl;
@property(nonatomic,retain) IBOutlet UILabel *statusLbl;
@property(nonatomic,retain) IBOutlet UILabel *classNameLbl;
@property(nonatomic,retain) IBOutlet UIView *controlsView;

@end
