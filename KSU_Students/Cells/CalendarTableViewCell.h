//
//  CalendarTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/13/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarObj.h"

@interface CalendarTableViewCell : UITableViewCell{
    UILabel* eventLbl;
    UILabel *fromLbl;
    UILabel *fromTextLbl;
    UILabel *toLbl;
    UILabel *toTextLbl;
    
    UIView *circle;
    UIView *circlesSepalator;
    
}
@property (nonatomic,retain) IBOutlet UILabel* eventLbl;
@property (nonatomic,retain) IBOutlet UILabel *fromLbl;
@property (nonatomic,retain) IBOutlet UILabel *fromTextLbl;
@property (nonatomic,retain) IBOutlet UILabel *toLbl;
@property (nonatomic,retain) IBOutlet UILabel *toTextLbl;

@property (nonatomic,retain) IBOutlet UIView *circle;
@property (nonatomic,retain) IBOutlet UIView *circlesSepalator;

-(void)initWithCalendarObj:(CalendarObj*)obj withRowIndex:(int)row;

@end