//
//  RecordsViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/10/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface RecordsViewController : BaseViewController<DataTransferDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableView;
    NSMutableArray *recordsLstArr;

    
    UIView *controlsView;
    
    UILabel * gradeLbl;
    UILabel * gradeLblVal;
    
}

@property(nonatomic,retain) IBOutlet UITableView *tableView;

@property(nonatomic,retain) IBOutlet UIView *controlsView;

@property(nonatomic,retain) IBOutlet UILabel * gradeLbl;
@property(nonatomic,retain) IBOutlet UILabel * gradeLblVal;



@end
