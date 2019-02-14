//
//  RecordTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/10/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseObj.h"

@interface RecordTableViewCell : UITableViewCell{
    CourseObj * cObj;
}
@property (nonatomic,retain) IBOutlet UILabel *courseCodeLbl;
@property (nonatomic,retain) IBOutlet UILabel *courseNameLbl;
@property (nonatomic,retain) IBOutlet UILabel *courseGradeLbl;
@property (nonatomic,retain) IBOutlet UILabel *courseHoursLbl;

-(void) initWithCourseObj:(CourseObj *)course withRowId:(int)rowID;
@end