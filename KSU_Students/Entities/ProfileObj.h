//
//  ProfileObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/20/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SemesterObj.h"
#import "StaticVariables.h"



typedef NS_ENUM( NSUInteger, Gender ){
    Male=0,
    Female
    
};
@interface ProfileObj : NSObject{
    
}

@property(nonatomic,retain) NSString *username;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,retain) NSString *studentId;
@property(nonatomic,retain) NSString *lastLogin;


@property(nonatomic,retain)NSString * name;
@property(nonatomic,retain)NSString * telNo;
@property(nonatomic,retain)NSString * faculty;
@property(nonatomic,retain)NSString * specialize;
@property(nonatomic,retain)NSString * status;
@property(nonatomic,retain)NSString * email;
@property(nonatomic,retain)NSString * nationalId;
@property(nonatomic,retain)NSString * nationality;
@property(nonatomic,retain)NSString * degree;

@property(nonatomic,retain)SemesterObj * currentSemester;
@property(nonatomic,retain) NSMutableArray *semestersArr;

@property(nonatomic) Gender studentGender;
@property(nonatomic) MyLanguages userLang;
@property(nonatomic) BOOL useTouchID;

-(void)initWithStudentId:(NSString*)student_id withCurrentSemester:(SemesterObj*)current withSemesters:(NSMutableArray*)arr;

@end
