//
//  RequestManager.h
//  KSU_Students
//
//  Created by EJ-Mac book on 6/7/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject

+ (RequestManager *)sharedInstance;

-(void)login:(id)delegate withUsername:(NSString*)user withPassword:(NSString*)pass;
-(void)getStudentProfile:(id)delegate withStudentId:(NSString*)studentId;
-(void)getStudentRewards:(id)delegate withStudentId:(NSString*)studentId;
-(void)getStudentTransaction:(id)delegate withStudentId:(NSString*)studentId;
-(void)getStudentLoans:(id)delegate withStudentId:(NSString*)studentId;
-(void)getStudentSchedule:(id)delegate withStudentId:(NSString*)studentId;
-(void)getStudentPlan:(id)delegate withStudentId:(NSString*)studentId;

-(void)getStudentResult:(id)delegate withStudentId:(NSString*)studentId withSemesterCode:(NSString*)semesterCode;

-(void)getStudentRecord:(id)delegate withStudentId:(NSString*)studentId;
-(void)getStudentBorrowedBooks:(id)delegate withStudentId:(NSString *)studentId;

-(void)StudentChangePW:(id)delegate withUsername:(NSString*)username withOldPW:(NSString*)oldPW withNewPW:(NSString*)nPass;

-(void)forgetPW:(id)delegate withUserName:(NSString*)username;

-(void)forgetPWVerify:(id)delegate withUserName:(NSString*)username withVerificationCode:(NSString*)code;
-(void)SendQRCode:(id)delegate withStudentNum:(NSString*)withStudentNum withCode:(NSString*)withCode;
@end
