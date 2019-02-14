//
//  LoansTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/30/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoansObj.h"

@interface LoansTableViewCell : UITableViewCell{
    UILabel *typeLbl;
    UILabel *amountLbl;
    UILabel *classYearLbl;
    
    LoansObj *lObj;
}

@property (nonatomic,retain) IBOutlet UILabel *typeLbl;
@property (nonatomic,retain) IBOutlet UILabel *amountLbl;
@property (nonatomic,retain) IBOutlet UILabel *classYearLbl;


-(void)initWithLoanObj:(LoansObj*)obj withRowId:(int)rowid;

@end
