//
//  ResultTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/6/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseObj.h"

@interface ResultTableViewCell : UITableViewCell{
    CourseObj * cObj;
}
@property (nonatomic,retain) IBOutlet UILabel *courseCodeLbl;
@property (nonatomic,retain) IBOutlet UILabel *courseNameLbl;
@property (nonatomic,retain) IBOutlet UILabel *courseGradeLbl;

-(void) initWithCourseObj:(CourseObj *)course withRowId:(int)rowID;
@end
