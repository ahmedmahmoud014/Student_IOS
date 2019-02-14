//
//  TransactionsTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/27/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransactionsObj.h"

@interface TransactionsTableViewCell : UITableViewCell{
    TransactionsObj* tObj;
}


@property (nonatomic,retain) IBOutlet UILabel * detailsLbl;
@property (nonatomic,retain) IBOutlet UILabel * classNameLbl;
@property (nonatomic,retain) IBOutlet UILabel * statusLbl;

-(void) initWithTransactionObj:(TransactionsObj*)obj withRowId:(int)rowId;
@end
