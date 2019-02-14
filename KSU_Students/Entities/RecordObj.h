//
//  RecordObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/10/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseObj.h"
#import "SemesterObj.h"

@interface RecordObj : NSObject{
    SemesterObj *semester;
    NSMutableArray * coursesArr;
    
}
@property (nonatomic,retain)  SemesterObj *semester;
@property (nonatomic,retain)  NSMutableArray * coursesArr;



@end
