//
//  RewardsTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 7/27/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "RewardsTableViewCell.h"

@implementation RewardsTableViewCell

@synthesize detailsLbl,amountLbl,dateLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - methods

-(void)initWithRewardsObj:(RewardsObj *)obj withRowId:(int)rowId{
    rObj=obj;
    
    detailsLbl.text=rObj.details;
    amountLbl.text=rObj.amount;
    dateLbl.text=rObj.date;
    
}

@end
