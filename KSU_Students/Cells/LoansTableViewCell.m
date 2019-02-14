//
//  LoansTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 7/30/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "LoansTableViewCell.h"

@implementation LoansTableViewCell
@synthesize classYearLbl,amountLbl,typeLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - methods

-(void)initWithLoanObj:(LoansObj*)obj withRowId:(int)rowid{
    lObj=obj;
    classYearLbl.text=lObj.classYear;
    amountLbl.text=lObj.amount;
    typeLbl.text=lObj.type;
}

@end
