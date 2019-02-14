//
//  TransactionsTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 7/27/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "TransactionsTableViewCell.h"

@implementation TransactionsTableViewCell
@synthesize detailsLbl,classNameLbl,statusLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) initWithTransactionObj:(TransactionsObj*)obj withRowId:(int)rowId{
    tObj=obj;
    detailsLbl.text = ([tObj.details length] == 0) ? @"-" : tObj.details;
    classNameLbl.text=tObj.className;
    statusLbl.text=tObj.status;
}

@end
