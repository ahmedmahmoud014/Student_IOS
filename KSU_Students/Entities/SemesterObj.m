//
//  SemesterObj.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/6/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "SemesterObj.h"

@implementation SemesterObj

@synthesize semesterId,semesterName,semesterGrade;

@synthesize status,major;

- (void) encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:semesterId forKey:@"semesterId"];
    [encoder encodeObject:semesterName forKey:@"semesterName"];
    [encoder encodeObject:semesterGrade forKey:@"semesterGrade"];
    [encoder encodeObject:status forKey:@"status"];
    [encoder encodeObject:major forKey:@"major"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    
    if (self)
    {
        semesterId = [coder decodeObjectForKey:@"semesterId"];
        semesterName = [coder decodeObjectForKey:@"semesterName"];
        semesterGrade = [coder decodeObjectForKey:@"semesterGrade"];
        status = [coder decodeObjectForKey:@"status"];
        major = [coder decodeObjectForKey:@"major"];
    }
    return self;
}

@end
