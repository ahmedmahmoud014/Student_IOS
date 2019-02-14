//
//  FullScheduleObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleObj.h"

@interface FullScheduleObj : NSObject{
//     NSMutableArray *saturdayArr;
     NSMutableArray *sundayArr;
     NSMutableArray *mondayArr;
     NSMutableArray *tuesdayArr;
     NSMutableArray *wednesdayArr;
     NSMutableArray *thursdayArr;
    NSMutableArray *othersArr;
}

//@property(nonatomic,retain) NSMutableArray *saturdayArr;
@property(nonatomic,retain) NSMutableArray *sundayArr;
@property(nonatomic,retain) NSMutableArray *mondayArr;
@property(nonatomic,retain) NSMutableArray *tuesdayArr;
@property(nonatomic,retain) NSMutableArray *wednesdayArr;
@property(nonatomic,retain) NSMutableArray *thursdayArr;
@property(nonatomic,retain) NSMutableArray *othersArr;

@end
