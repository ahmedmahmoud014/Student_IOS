//
//  CustomError.h
//  KSU_Students
//
//  Created by EJ-Mac book on 6/7/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomError : NSObject

//@property (nonatomic ,readwrite) int errorCode;
//@property (nonatomic, retain)   NSString *erroeCodeString;
@property (nonatomic, retain)NSString *errorMessage;

+(id)initWithError:(id)data;

@end
