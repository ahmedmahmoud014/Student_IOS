//
//  PlanTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "PlanTableViewCell.h"
#import "LocalizedMessages.h"

@implementation PlanTableViewCell
@synthesize courseCodeLbl,courseNameLbl,courseImg,courseTypeLbl;
@synthesize xPos,width;
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithCourseObj:(CourseObj*)obj withRowId:(int)rowId withTaken:(BOOL)isTaken{
    cObj=obj;
    courseNameLbl.text=cObj.CourseName;
    courseCodeLbl.text=cObj.CourseCode;

    courseTypeLbl.text=cObj.courseType;
    
    
    if (cObj.currentSemester == TRUE) {
        courseImg.image=[UIImage imageNamed:@"plan_orange.png"];
        /*if(imgConstr!=nil){
            [self removeConstraint:imgConstr];
        }
        
        imgConstr=[NSLayoutConstraint constraintWithItem:courseImg
                                               attribute:NSLayoutAttributeWidth
                                               relatedBy:NSLayoutRelationEqual
                                                  toItem:nil
                                               attribute:NSLayoutAttributeNotAnAttribute
                                              multiplier:1.0
                                                constant:4];
        [self addConstraint:imgConstr];*/
        
        
       [courseImg setNeedsDisplay];
        [courseImg updateConstraints];
        [courseImg updateConstraintsIfNeeded];

        [courseImg setNeedsLayout];

    }
    else
    {
        if(rowId%4==PlanBlue){
            courseImg.image=[UIImage imageNamed:@"plan_blue.png"];
        }else if(rowId%4==PlanRed){
            courseImg.image=[UIImage imageNamed:@"plan_red.png"];
        }else if(rowId%4==PlanPurple){
            courseImg.image=[UIImage imageNamed:@"plan_purper.png"];
        }else if(rowId%4==PlanGreen){
            courseImg.image=[UIImage imageNamed:@"plan_green.png"];
        }
      
        /*if(imgConstr!=nil){
            [self removeConstraint:imgConstr];
        }
        
        imgConstr=[NSLayoutConstraint constraintWithItem:courseImg
                                               attribute:NSLayoutAttributeWidth
                                               relatedBy:NSLayoutRelationEqual
                                                  toItem:nil
                                               attribute:NSLayoutAttributeNotAnAttribute
                                              multiplier:1.0
                                                constant:4];
        [self addConstraint:imgConstr];*/

        
        [courseImg setNeedsDisplay];
        [courseImg setNeedsLayout];

        [courseImg updateConstraints];
        

    }
     

    
    /*if(rowId%5==PlanBlue){
        courseImg.image=[UIImage imageNamed:@"plan_blue.png"];
    }else if(rowId%5==PlanRed){
        courseImg.image=[UIImage imageNamed:@"plan_red.png"];
    }else if(rowId%5==PlanOrange){
        courseImg.image=[UIImage imageNamed:@"plan_orange.png"];
    }else if(rowId%5==PlanPurple){
        courseImg.image=[UIImage imageNamed:@"plan_purper.png"];
    }else if(rowId%5==PlanGreen){
        courseImg.image=[UIImage imageNamed:@"plan_green.png"];
    }*/
    
    
    if(isTaken){
        courseCodeLbl.textColor=[UIColor colorWithRed:255.0/255.0 green:128.0/255.0 blue:0.0/255.0 alpha:1];        
    }else{
        courseCodeLbl.textColor=[UIColor colorWithRed:75.0/255.0 green:193.0/255.0 blue:293.0/255.0 alpha:1];

    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView updateConstraints];
    

}

@end
