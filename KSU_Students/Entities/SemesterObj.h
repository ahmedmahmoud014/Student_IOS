//
//  SemesterObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/6/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SemesterObj : NSObject <NSCoding> {
    NSString * semesterId;
    NSString * semesterName;
    NSString * semesterGrade;
    
    NSString * status;
    NSString * major;
}

@property (nonatomic,retain)  NSString * semesterId;
@property (nonatomic,retain)  NSString * semesterName;
@property (nonatomic,retain)  NSString * semesterGrade;

@property (nonatomic,retain)  NSString * status;
@property (nonatomic,retain)  NSString * major;

@end
