//
//  CustomError.m
//  KSU_Students
//
//  Created by EJ-Mac book on 6/7/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "CustomError.h"
#import "LocalizedMessages.h"
#import "StaticVariables.h"

@implementation CustomError


//@synthesize errorCode;
@synthesize errorMessage;
//@synthesize erroeCodeString;

+ (id)initWithError:(id)data   {
    
    return [[CustomError alloc] initWithData:data];
}

- (id)initWithData:(id)data {
    
    self = [super init];
    if (self) {
        
        //[self setErrorCode:[[data valueForKeyPath:MWErrorCode] intValue]];
        if([data valueForKeyPath:MWErrorMessage]!=[NSNull null])
            [self setErrorMessage:[data valueForKeyPath:MWErrorMessage]];
        else
            [self setErrorMessage:ErrorGeneralTitle];
        
    }
    return self;
}

@end
