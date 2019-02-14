//
//  CourseObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM( NSUInteger, CourseType ){
    TakenCourse=0,
    WillTakeCourse=1,
    CurrentCourse
};


typedef NS_ENUM( NSUInteger, PlanColors ){
    PlanBlue=0,
    PlanRed,
   // PlanOrange,
    PlanPurple,
    PlanGreen
    
};

@interface CourseObj : NSObject{
    NSString * CourseCode;
    NSString * CourseName;
    NSString * grade;
    NSString * courseType;
    NSString * attemptedHrs;
    BOOL currentSemester;
}
@property (nonatomic,retain) NSString * CourseCode;
@property (nonatomic,retain) NSString * CourseName;
@property (nonatomic,retain) NSString * grade;
@property (nonatomic,retain) NSString * courseType;
@property (nonatomic,retain) NSString * attemptedHrs;
@property (nonatomic) BOOL currentSemester;

@end
