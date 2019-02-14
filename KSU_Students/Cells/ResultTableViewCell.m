//
//  ResultTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/6/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "ResultTableViewCell.h"

@implementation ResultTableViewCell

@synthesize courseCodeLbl,courseGradeLbl, courseNameLbl;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - methods

-(void) initWithCourseObj:(CourseObj *)course withRowId:(int)rowID{
    cObj=course;
    courseCodeLbl.text=cObj.CourseCode;
    if (![cObj.grade isKindOfClass:[NSNull class]]){
       courseGradeLbl.text=cObj.grade;
    }
    else{
        courseGradeLbl.text=  @"";
    }
    courseNameLbl.text=cObj.CourseName;
}

@end
