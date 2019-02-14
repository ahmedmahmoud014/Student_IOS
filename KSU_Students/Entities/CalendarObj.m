//
//  CalendarObj.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/13/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "CalendarObj.h"
#import "StaticVariables.h"
#import "LocalizationSystem.h"

@implementation CalendarObj
@synthesize event;
@synthesize georgDate;
@synthesize hijriDate;

+(NSMutableArray*)getCalendarData:(BOOL)isVaction{
    NSString *fileName=@"CalendarData";
    if(isVaction)
        fileName=@"VacationData";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *arr=[json valueForKeyPath:calendarListJson];
    NSMutableArray* calendarArr=[[NSMutableArray alloc] init];
    for (int i=0; i<[arr count]; i++) {
        CalendarObj* obj= [[CalendarObj alloc] init];
        obj.hijriDate=[[arr objectAtIndex:i] valueForKeyPath:calendarHijriJson];
        obj.georgDate=[[arr objectAtIndex:i] valueForKeyPath:calendarGreogJson];
        obj.event= ICLocalizedString([[arr objectAtIndex:i] valueForKeyPath:calendarTypeJson],@"");
        if(![CalendarObj checkIFPassToday:obj.georgDate])
            [calendarArr addObject:obj];
    }
    
    return calendarArr;
    
}

+(BOOL)checkIFPassToday:(NSString*)dateStr{
    NSDate *today = [NSDate date];
    NSCalendar *gregorianCalendar =[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorianCalendar rangeOfUnit:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear startDate:&today interval:NULL forDate:today];
//    NSCalendar *gregorianCalendar =[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    [gregorianCalendar rangeOfUnit:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit startDate:&today interval:NULL forDate:today];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:gregorianCalendar];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date1=[dateFormatter dateFromString:dateStr];
    // NSLog(@"%@",date1);
    
    if([date1 timeIntervalSinceNow]<0.0){
        return YES;
    }
    return NO;
}

@end
