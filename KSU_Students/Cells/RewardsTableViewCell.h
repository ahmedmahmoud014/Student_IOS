//
//  RewardsTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/27/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RewardsObj.h"

@interface RewardsTableViewCell : UITableViewCell{
    RewardsObj *rObj;
}

@property(nonatomic ,retain)IBOutlet UILabel *amountLbl;
@property(nonatomic ,retain)IBOutlet UILabel *detailsLbl;
@property(nonatomic ,retain)IBOutlet UILabel *dateLbl;

-(void)initWithRewardsObj:(RewardsObj*)obj withRowId:(int)rowId;
@end
