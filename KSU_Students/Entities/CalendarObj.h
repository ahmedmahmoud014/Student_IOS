//
//  CalendarObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/13/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarObj : NSObject{
    NSString *event;
    NSString *georgDate;
    NSString *hijriDate;
}

@property (nonatomic,retain) NSString *event;
@property (nonatomic,retain) NSString *georgDate;
@property (nonatomic,retain) NSString *hijriDate;

+(NSMutableArray*)getCalendarData:(BOOL)isVaction;
@end
