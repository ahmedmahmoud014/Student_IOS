//
//  ResultObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/6/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SemesterObj.h"
#import "CourseObj.h"

@interface ResultObj : NSObject{
    SemesterObj *semester;
    NSString * cumGrade;
    NSMutableArray * coursesArr;
    
}
@property (nonatomic,retain)  SemesterObj *semester;
@property (nonatomic,retain)  NSString * cumGrade;
@property (nonatomic,retain)  NSMutableArray * coursesArr;

@end
