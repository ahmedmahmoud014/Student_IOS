//
//  PlanTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseObj.h"

@interface PlanTableViewCell : UITableViewCell{
    CourseObj * cObj;
    NSLayoutConstraint *imgConstr;
    
}

@property (nonatomic) NSInteger  xPos;
@property (nonatomic) NSInteger  width;
@property (nonatomic,retain) IBOutlet UILabel * courseNameLbl;
@property (nonatomic,retain) IBOutlet UILabel * courseCodeLbl;
@property (nonatomic,retain) IBOutlet UILabel * courseTypeLbl;
@property (nonatomic,retain) IBOutlet UIImageView * courseImg;

-(void)initWithCourseObj:(CourseObj*)obj withRowId:(int)rowId withTaken:(BOOL)isTaken;
@end
