//
//  StaticFuntions.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/20/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileObj.h"

@interface StaticFuntions : NSObject

+ (void)showAlertWithTitle:(NSString *)title Message:(NSString *)message ;
+ (BOOL)isStringEmpty:(NSString *)string ;


+ (void)createFile:(ProfileObj*)obj;
+ (ProfileObj*)getSavedData;
+ (BOOL)UpdateLoginDate:(NSString*)currentDate;
+ (void)clearProfileData;

+(void)UpdateFile:(ProfileObj*)obj;
+(void)createTouchIDFile:(ProfileObj*)obj;
+(ProfileObj*)getSavedTouchIDData;

@end
