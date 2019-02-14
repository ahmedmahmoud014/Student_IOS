//
//  ProfileObj.m
//  KSU_Students
//
//  Created by EJ-Mac book on 7/20/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "ProfileObj.h"
#import "AppDelegate.h"

@implementation ProfileObj
@synthesize username;
@synthesize password;
@synthesize studentId;
@synthesize lastLogin;

@synthesize name;
@synthesize telNo;
@synthesize faculty;
@synthesize specialize;
@synthesize status;
@synthesize email;
@synthesize nationalId;
@synthesize nationality;
@synthesize degree;

@synthesize studentGender;
@synthesize currentSemester;
@synthesize semestersArr;
@synthesize userLang;

@synthesize useTouchID;

-(void)initWithStudentId:(NSString *)student_id withCurrentSemester:(SemesterObj *)current withSemesters:(NSMutableArray *)arr{
    studentId=student_id;
    semestersArr=arr;
    currentSemester=current;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    userLang=appDelegate.currentLang;
}

@end
