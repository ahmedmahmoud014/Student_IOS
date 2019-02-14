//
//  ChangePWObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/15/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangePWObj : NSObject{
    NSString *passwordOld;
    NSString *passwordNew;
    NSString *passwordConfirm;
    NSString *username;
}

@property (nonatomic,retain) NSString *username;
@property (nonatomic,retain) NSString *passwordOld;
@property (nonatomic,retain) NSString *passwordNew;
@property (nonatomic,retain) NSString *passwordConfirm;

-(BOOL)validateConfirmationPw;


@end
