//
//  ScheduleObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM( NSUInteger, ScheduleDays ){
  //  Saturday=0,
    Sunday=0,
    Monday,
    Tuesday,
    Wednesday,
    Thursday    
};

@interface ScheduleObj : NSObject{

    NSString * classBuildingId;
    NSString * classpartitionId;
    NSString * classFloorId;
    NSString * classRoomId;
    
    NSString * classInstractorId;
    
    NSString * classJobTitle;
    
    NSString * courseNo;
    NSString * startTime;
    NSString * endTime;
    NSString * SectionNo;
    //ScheduleDays day;
    NSString *day;
}

@property (nonatomic,retain) NSString * classBuildingId;
@property (nonatomic,retain) NSString * classpartitionId;
@property (nonatomic,retain) NSString * classFloorId;
@property (nonatomic,retain) NSString * classRoomId;
@property (nonatomic,retain) NSString * classInstractorId;
@property (nonatomic,retain) NSString * classJobTitle;
@property (nonatomic,retain) NSString * courseNo;
@property (nonatomic,retain) NSString * startTime;
@property (nonatomic,retain) NSString * endTime;
@property (nonatomic,retain) NSString * SectionNo;
//@property (nonatomic) ScheduleDays day;
@property (nonatomic) NSString* day;

@end
