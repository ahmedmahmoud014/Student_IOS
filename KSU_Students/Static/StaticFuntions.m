//
//  StaticFuntions.m
//  KSU_Students
//
//  Created by EJ-Mac book on 7/20/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "StaticFuntions.h"
#import "LocalizedMessages.h"


@implementation StaticFuntions

+ (void)showAlertWithTitle:(NSString *)title Message:(NSString *)message {
    NSString * messageTitle = title ? title : ApplicationTitleText;
    [[[UIAlertView alloc] initWithTitle:messageTitle
                                message:message
                               delegate:nil
                      cancelButtonTitle:OKayButtonText
                      otherButtonTitles:nil] show];
}

+ (BOOL)isStringEmpty:(NSString *)string  {
    NSString *rawString = string;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        return YES;
    }
    return NO;
}

+(void)createFile:(ProfileObj*)obj{
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *todayDate = [formatter stringFromDate:[NSDate date]];
    
    
    if (![fileManager fileExistsAtPath: path]){
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [data setObject:obj.username forKey:@"username"];
    [data setObject:obj.password forKey:@"password"];

    [data setObject:obj.studentId forKey:@"studentId"];
    [data setObject:[NSNumber numberWithInt:(int)obj.userLang] forKey:@"userLang"];
    [data setObject:todayDate forKey:@"lastLogin"];
    
    if(obj.currentSemester==nil||obj.currentSemester.semesterId==nil)
        [data setObject:@"" forKey:@"currentSemesterID"];
    else
        [data setObject:obj.currentSemester.semesterId forKey:@"currentSemesterID"];
    if(obj.currentSemester==nil||obj.currentSemester.semesterName==nil)
        [data setObject:@"" forKey:@"currentSemesterName"];
    else
        [data setObject:obj.currentSemester.semesterName forKey:@"currentSemesterName"];
    
    [data setObject:[NSNumber numberWithInteger:[obj.semestersArr count]] forKey:@"semesterCount"];
    for (int i=0; i<[obj.semestersArr count]; i++) {
        SemesterObj * sem=[obj.semestersArr objectAtIndex:i];
        [data setObject:sem.semesterId forKey:[NSString stringWithFormat: @"SemesterID%d",i]];
        [data setObject:sem.semesterName forKey:[NSString stringWithFormat:@"SemesterName%d",i]];
    }
    [data setObject:[NSNumber numberWithBool: obj.useTouchID] forKey:@"useTouchID"];
    
    
   
    [data writeToFile: path atomically:YES];
    
}
+(void)UpdateFile:(ProfileObj*)obj
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]){
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [data setObject:[NSNumber numberWithBool: obj.useTouchID] forKey:@"useTouchID"];
    [data writeToFile: path atomically:YES];
}
+(void)createTouchIDFile:(ProfileObj*)obj
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"TouchIDdata.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]){
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"TouchIDdata" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [data setObject:obj.username forKey:@"userName"];
    [data setObject:obj.password forKey:@"password"];
    [data writeToFile: path atomically:YES];
}
+(ProfileObj*)getSavedTouchIDData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"TouchIDdata.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: path])
    {
        NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        ProfileObj *obj=[[ProfileObj alloc]init];
        
        obj.username= [savedData objectForKey:@"userName"];
        obj.password= [savedData objectForKey:@"password"];
        return obj;
    }
    return nil;
}


+(ProfileObj*)getSavedData{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: path]){
        NSMutableDictionary *savedData = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        
        ProfileObj *obj=[[ProfileObj alloc]init];
        obj.username= [savedData objectForKey:@"username"];
        obj.password= [savedData objectForKey:@"password"];
        obj.studentId= [savedData objectForKey:@"studentId"];
        obj.userLang=(MyLanguages)[[savedData objectForKey:@"userLang"] intValue];
        obj.lastLogin = [savedData objectForKey:@"lastLogin"];
        
      
        
        obj.currentSemester=[[SemesterObj alloc] init];
        obj.currentSemester.semesterId =  [savedData objectForKey:@"currentSemesterID"];
        obj.currentSemester.semesterName =  [savedData objectForKey:@"currentSemesterName"];
        
        int semesterCount=[[savedData objectForKey:@"semesterCount"] intValue];
        if(semesterCount>0){
            obj.semestersArr=[[NSMutableArray alloc] init];
            for(int i=0;i<semesterCount;i++){
                SemesterObj *sem=[[SemesterObj alloc] init];
                sem.semesterId= [savedData objectForKey:[NSString stringWithFormat:@"SemesterID%d",i]];
                 sem.semesterName= [savedData objectForKey:[NSString stringWithFormat:@"SemesterName%d",i]];
                [obj.semestersArr addObject:sem];
            }
        }

        obj.useTouchID=[[savedData objectForKey:@"useTouchID"]boolValue];
        
        return obj;
    }
    return nil;
}

+ (BOOL)UpdateLoginDate:(NSString*)currentDate
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]){
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];

    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [formatter dateFromString:[data objectForKeyedSubscript:@"lastLogin"]];
    NSDate *endDate = [formatter dateFromString:currentDate];
    
    NSTimeInterval secondsBetween = [endDate timeIntervalSinceDate:startDate];
    int numberOfDays = secondsBetween / 86400;
    
    if (numberOfDays <= 5) {
        [data setObject:currentDate forKey:@"lastLogin"];
        [data writeToFile: path atomically:YES];
        return YES;
    }
    
    return NO;
    
}

+(void) clearProfileData{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]){
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [data setObject:@"" forKey:@"username"];
    [data setObject:@"" forKey:@"password"];
    [data setObject:@"" forKey:@"studentId"];
    [data setObject:[NSNumber numberWithInt:(int)Arabic] forKey:@"userLang"];
    [data setObject:@"" forKey:@"lastLogin"];
    
    [data setObject:@"" forKey:@"currentSemesterID"];
    [data setObject:@"" forKey:@"currentSemesterName"];
    [data setObject:[NSNumber numberWithInteger:0] forKey:@"semesterCount"];
    
    //[data setObject:@"" forKey:@"semestersArr"];
    

   
    [data writeToFile: path atomically:YES];
    
}
@end
