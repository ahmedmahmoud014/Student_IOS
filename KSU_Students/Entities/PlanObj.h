//
//  PlanObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanObj : NSObject{
    NSMutableArray * coursesTakenArr;
    NSMutableArray * courseWillBeTakenArr;
    NSMutableArray * coursesCurrentArr;
}
@property (nonatomic,retain) NSMutableArray * coursesTakenArr;
@property (nonatomic,retain) NSMutableArray * courseWillBeTakenArr;
@property (nonatomic,retain) NSMutableArray * coursesCurrentArr;
@end
