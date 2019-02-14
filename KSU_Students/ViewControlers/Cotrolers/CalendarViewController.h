//
//  CalendarViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/13/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"

@interface CalendarViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{

    UITableView *tableView;
    NSMutableArray * calenderArr;
    UIView *english;
    
}

@property(nonatomic,retain) IBOutlet UITableView *tableView;

@end
