//
//  RequestManager.m
//  KSU_Students
//
//  Created by EJ-Mac book on 6/7/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "RequestManager.h"
#import "StaticVariables.h"
#import "DataTransfer.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "LocalizedMessages.h"
#import "ProfileObj.h"
#import "RewardsObj.h"
#import "TransactionsObj.h"
#import "LoansObj.h"
#import "ScheduleObj.h"
#import "PlanObj.h"
#import "CourseObj.h"
#import "SemesterObj.h"
#import "ResultObj.h"
#import "RecordObj.h"
#import "BookObj.h"

@implementation RequestManager

+ (RequestManager *)sharedInstance   {
    static RequestManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RequestManager alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getFullServiceString:(Service)service  {
    if(service==StudentBooks_WS)
        return [NSString stringWithFormat:@"%@%@",MW_URLBooks,[self getStringForService:service]];
    
    return [NSString stringWithFormat:@"%@%@%@",MW_URL,[self getServiceName],[self getStringForService:service]];
}


-(NSString *)getServiceName{
    return MWServiceName;
}

- (NSString *)getStringForService:(Service)service   {
    
    NSString * serviceString ;
    switch (service) {
        case Login_WS:
            serviceString = MW_LoginWS;
            break;
        case StudentProfile_WS:
            serviceString = MW_StudentProfile_WS;
            break;
        case StudentRewards_WS:
            serviceString = MW_StudentRewards_WS;
            break;
        case StudentTransaction_WS:
            serviceString = MW_StudentTransaction_WS;
            break;
        case Student_Loan_WS:
            serviceString = MW_StudentLoans_WS;
            break;
        case StudentSchedule_WS:
            serviceString = MW_StudentSchedule_WS;
            break;
        case StudentPlan_WS:
            serviceString = MW_StudentPlan_WS;
            break;
        case StudentResult_WS:
            serviceString = MW_StudentResult_WS;
            break;
        case StudentRecords_WS:
            serviceString = MW_StudentRecords_WS;
            break;
        case StudentBooks_WS:
            serviceString = MW_StudentBooks_WS;
            break;
        case ChangePW_WS:
            serviceString=MW_ChangePW_WS;
            break;
        case ForgetPassword_WS:
            serviceString=MW_ForgetPassword_WS;
            break;
        case ForgetPasswordActiv_WS:
            serviceString=MW_ForgetPasswordActiv_WS;
            break;
        default:
            break;
    }
    return serviceString;
    
}

+ (NSString *)addSecretKeyURL:(NSString*)URL{
    return [NSString stringWithFormat:@"%@%@%@",URL,MW_GeneralDel,MW_ScreatKeyParam];
}
+ (NSString *)addSecretKeyURLWithout:(NSString*)URL{
    return [NSString stringWithFormat:@"%@%@%@",URL,MW_GeneralDel,MW_ScreatKeyParamWithout];
}

+ (NSString *)addLanguageURL:(NSString*)URL{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [NSString stringWithFormat:@"%@%@%@%d",URL,MW_GeneralDel,MWlanguageParam,(int)appDelegate.currentLang];
}

#pragma mark - private methods

- (NSString *)stringIntParam:(NSString *)key value:(int)value   {
    
    return [NSString stringWithFormat:@"%@%d",key,value];
}
- (NSString *)stringDoubleParam:(NSString *)key value:(double)value   {
    
    return [NSString stringWithFormat:@"%@%f",key,value];
}
- (NSString *)stringParam:(NSString *)key value:(NSString *)value {
    
    return [NSString stringWithFormat:@"%@%@",key,value];
}

- (NSString *)stringBoolParam:(NSString *)key value:(BOOL)value {
    
    return [NSString stringWithFormat:@"%@%d",key,value?1:0];
}
#pragma mark - web services

-(void)login:(id)delegate withUsername:(NSString*)user withPassword:(NSString*)pass{
    Service serv= Login_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"login url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDictionary *parameter = @{loginUserName_MW:/*@"IntegrationTest01"*//*@"IntegrationStdUser01"*/user,
                                loginPassword_MW:/*@"12345678"*//*@"Int@12345"*/pass,
                                MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang],
                                MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue};
    NSLog(@"JSON parameter: %@", parameter);

    
    /*IntegrationTest01&Password=12345678*/
    /*{"UserName":"IntegrationStdUser01","Password":"Int@12345","Language":1,"SKey":"943D4D1F-E067-4534-B80A-D5618D38C213"}*/
    
    [manager POST:[url absoluteString]
      parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

             NSLog(@"JSON success: %@", responseObject);
             id result = [responseObject objectForKeyedSubscript:loginResults_MW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
              NSString *currentSemId;
             if (operationStatus) {
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW] ;
                 NSString *studentId=[[objPay objectAtIndex:0]  objectForKeyedSubscript:StudentId_MW];
                 // check id 
                 if (![[[objPay objectAtIndex:0]  objectForKeyedSubscript:currentSemesterMW] isKindOfClass:[NSNull class]] ){
               currentSemId=[[objPay objectAtIndex:0]  objectForKeyedSubscript:currentSemesterMW];
                 
                 }
                //  end check  condition
                 else {
                     currentSemId = @"no value exist";
                 }
                 NSArray* objSem =(NSArray*) [result objectForKeyedSubscript:semesterObjLstMW];
                 NSMutableArray* semesters=[[NSMutableArray alloc] init];
                 SemesterObj *current=nil;
                 
                 if(currentSemId){
                     current=[[SemesterObj alloc] init];
                     current.semesterId=currentSemId;
                 }
                 
                // if ([objSem count] > 0) {
                     for (int i=0; i<[objSem count]; i++) {
                         SemesterObj *obj=[[SemesterObj alloc] init];
                         obj.semesterId=[[objSem objectAtIndex:i]  objectForKeyedSubscript:semesterIdMW];
                         obj.semesterName=[[objSem objectAtIndex:i]  objectForKeyedSubscript:semesterNameMW];
                         if([currentSemId isEqualToString:obj.semesterId]){
                             current.semesterName=obj.semesterName;
                         }
                         [semesters addObject:obj];
                     }
                     ProfileObj *obj=[[ProfileObj alloc] init];
                     [obj initWithStudentId:studentId withCurrentSemester:current withSemesters:semesters];
                     [dataTransfer dataLoaded:obj error:nil withService:serv];
                 }
//                 else
//                 {
//                     CustomError * customError = [[CustomError alloc] init];
//                     customError.errorMessage=ServerErrorMsg;
//                     [dataTransfer dataLoaded:nil error:customError withService:serv];
//
//                 }
   
         // }
             else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
         }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

             // Handle failure
              NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

-(void)getStudentProfile:(id)delegate withStudentId:(NSString*)studentId{
   // studentId=@"422020399";
    Service serv= StudentProfile_WS;
    
    NSString *urlString= [NSString stringWithFormat:@"%@",[self getFullServiceString:serv] ];
//    urlString=[RequestManager addLanguageURL:urlString];
//    urlString=[RequestManager addSecretKeyURL:urlString];
    NSLog(@"Student Profile url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSDictionary *parameter = @{StudentID: studentId ,MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue,
                                 MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang]};
    NSLog(@"JSON parameter: %@", parameter);
    
    
    [manager POST:[url absoluteString]
       parameters:parameter
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

              NSLog(@"JSON: %@", responseObject);
              id result = [responseObject objectForKeyedSubscript:profileResultMW];
              id op_result= [result objectForKeyedSubscript:ObjResultMW];
              BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
              
              if (operationStatus) {
                  NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
                  ProfileObj *obj=[[ProfileObj alloc] init];
                  obj.studentId=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileStudentIdMW];
                  if (![[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileDegreeMW] isKindOfClass:[NSNull class]]){
                   obj.degree=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileDegreeMW];
                  }else {
                      obj.degree = @"";
                  }
                   obj.email=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileEmailMW];
                   obj.faculty=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileFacultyMW];
                   obj.studentGender= (Gender)(![[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileIsMaleMW] boolValue]);
                  
                  if (![[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileMajorMW] isKindOfClass:[NSNull class]]){
                      obj.specialize=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileMajorMW];
                  }else {
                      obj.specialize = @"";
                  }
                   obj.nationalId=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileNationalIdMW];
                   obj.nationality=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileNationalityMW];
                   obj.status=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileStatusMW];
                   obj.name=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileStudentNameMW];
                   obj.telNo=[[objPay objectAtIndex:0]  objectForKeyedSubscript:profileTelNoMW];
                  
                  [dataTransfer dataLoaded:obj error:nil withService:serv];
              }else{
                  CustomError *customError = [CustomError initWithError:op_result];
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
                  
              }
          }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

              // Handle failure
              NSLog(@"failed: %@",error);
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)getStudentRewards:(id)delegate withStudentId:(NSString*)studentId{
    //studentId=@"433102617";
    Service serv= StudentRewards_WS;
    
    NSString *urlString= [NSString stringWithFormat:@"%@",[self getFullServiceString:serv]];
//    urlString=[RequestManager addLanguageURL:urlString];
//    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"Student Rewards url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *parameter = @{StudentID: studentId ,MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue,
                                MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang]};
    NSLog(@"JSON parameter: %@", parameter);
    
    
    [manager POST:[url absoluteString]
      parameters:parameter
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

             NSLog(@"JSON: %@", responseObject);
             id result = [responseObject objectForKeyedSubscript:rewardsResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 NSMutableArray *lst=[[NSMutableArray alloc] init];
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
                 for(int i=0;i<[objPay count];i++){
                     RewardsObj *obj=[[RewardsObj alloc] init];
                     obj.details=[[objPay objectAtIndex:i]  objectForKeyedSubscript:rewardsDetailsMW];
                     obj.date=[[objPay objectAtIndex:i]  objectForKeyedSubscript:rewardsDateMW];
                     obj.amount=[[objPay objectAtIndex:i]  objectForKeyedSubscript:rewardsAmountMW];
                     [lst addObject:obj];
                 }
                [dataTransfer dataLoaded:lst error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

-(void)getStudentTransaction:(id)delegate withStudentId:(NSString*)studentId{
   // studentId=@"433102837";
    Service serv= StudentTransaction_WS;
    
    NSString *urlString= [NSString stringWithFormat:@"%@",[self getFullServiceString:serv]];
//    urlString=[RequestManager addLanguageURL:urlString];
//    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"Student Transaction url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *parameter = @{StudentID: studentId ,MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue,
                                MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang]};
    NSLog(@"JSON parameter: %@", parameter);
    
    
    [manager POST:[url absoluteString]
      parameters:parameter
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             NSLog(@"JSON: %@", responseObject);
             id result = [responseObject objectForKeyedSubscript:transactionResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 NSMutableArray *lst=[[NSMutableArray alloc] init];
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
                 for(int i=0;i<[objPay count];i++){
                     TransactionsObj *obj=[[TransactionsObj alloc] init];
                     obj.details=[[objPay objectAtIndex:i]  objectForKeyedSubscript:transactionDetailsMW];
                     obj.className=[[objPay objectAtIndex:i]  objectForKeyedSubscript:transactionCourseNameMW];
                     obj.status=[[objPay objectAtIndex:i]  objectForKeyedSubscript:transactionStatusMW];
                     [lst addObject:obj];
                 }
                 [dataTransfer dataLoaded:lst error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)getStudentLoans:(id)delegate withStudentId:(NSString*)studentId{
   // studentId=@"433107973";
    Service serv= Student_Loan_WS;
    
    NSString *urlString= [NSString stringWithFormat:@"%@",[self getFullServiceString:serv]];
//    urlString=[RequestManager addLanguageURL:urlString];
//    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"Student Loans url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *parameter = @{StudentID: studentId ,MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue,
                                MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang]};
    NSLog(@"JSON parameter: %@", parameter);
    
    
    [manager POST:[url absoluteString]
      parameters:parameter
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             NSLog(@"JSON: %@", responseObject);
             id result = [responseObject objectForKeyedSubscript:loanResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 NSMutableArray *lst=[[NSMutableArray alloc] init];
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
                 for(int i=0;i<[objPay count];i++){
                     LoansObj *obj=[[LoansObj alloc] init];
                     obj.classYear=[[objPay objectAtIndex:i]  objectForKeyedSubscript:loanCourseYearMW];
                     obj.type=[[objPay objectAtIndex:i]  objectForKeyedSubscript:loanTypeMW];
                     obj.amount=[[objPay objectAtIndex:i]  objectForKeyedSubscript:loanAmountMW];
                     [lst addObject:obj];
                 }
                 [dataTransfer dataLoaded:lst error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)getStudentSchedule:(id)delegate withStudentId:(NSString*)studentId{
    //studentId=@"432201000";
    Service serv= StudentSchedule_WS;
    
    NSString *urlString= [NSString stringWithFormat:@"%@",[self getFullServiceString:serv] ];
    //urlString=[RequestManager addLanguageURL:urlString];
   // urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"Student schedule url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *parameter = @{StudentID: studentId ,MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue,
                                MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang]};
    NSLog(@"JSON parameter: %@", parameter);
    
    [manager POST:[url absoluteString]
      parameters:parameter
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             NSLog(@"JSON: %@", responseObject);
             id result = [responseObject objectForKeyedSubscript:scheduleResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 NSMutableArray *lst=[[NSMutableArray alloc] init];
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
                 for(int i=0;i<[objPay count];i++){
                     ScheduleObj *obj=[[ScheduleObj alloc] init];
                     obj.classRoomId=([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleClassroomIdMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleClassroomIdMW];
                     // DAY = "" -> OTHER
                     
                     
                     
                     obj.day= ([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleDayMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleDayMW];
                     obj.courseNo=([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleCourseCodeMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleCourseCodeMW];
                     obj.startTime=([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleFromTimeMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleFromTimeMW];
                     obj.endTime=([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleEndTimeMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleEndTimeMW];
                     obj.SectionNo=([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleSectionIDMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleSectionIDMW];
                     
                     obj.classBuildingId=([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleClassbuildingIdMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleClassbuildingIdMW];
                     obj.classpartitionId=([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleClassPartitionIdMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleClassPartitionIdMW];
                     obj.classFloorId=([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleClassfloorIdMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleClassfloorIdMW];
                     obj.classRoomId=([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleClassroomIdMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleClassroomIdMW];
                     
                     obj.classInstractorId=([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleClassinstractorIdMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleClassinstractorIdMW];
                     
                     obj.classJobTitle=([[[objPay objectAtIndex:i] objectForKeyedSubscript:scheduleClassJobTitleMW] isKindOfClass:[NSNull class]]) ? DATA_NOT_AVAILABLE : [[objPay objectAtIndex:i]  objectForKeyedSubscript:scheduleClassJobTitleMW];
                     
                     [lst addObject:obj];
                 }
                 [dataTransfer dataLoaded:lst error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)getStudentPlan:(id)delegate withStudentId:(NSString*)studentId{
    //studentId=@"433202442";
    Service serv= StudentPlan_WS;
    
    NSString *urlString= [NSString stringWithFormat:@"%@",[self getFullServiceString:serv]];
//    urlString=[RequestManager addLanguageURL:urlString];
//    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"Student plan url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *parameter = @{StudentID: studentId ,MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue,
                                MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang]};
    NSLog(@"JSON parameter: %@", parameter);
    
    
    [manager POST:[url absoluteString]
      parameters:parameter
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             NSLog(@"JSON: %@", responseObject);
             id result = [responseObject objectForKeyedSubscript:planResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 PlanObj *plan=[[PlanObj alloc] init];
                 plan.coursesTakenArr=[[NSMutableArray alloc] init];
                 plan.courseWillBeTakenArr=[[NSMutableArray alloc] init];
                 plan.coursesCurrentArr=[[NSMutableArray alloc] init];
               //  NSDictionary* objPay =(NSDictionary*)[result objectForKeyedSubscript:ObjPayMW]  ;
                 NSArray* objCourseTaken =(NSArray*) [result objectForKeyedSubscript:planCoursesTakenMW]  ;
                  NSArray* objCoursewillTake =(NSArray*) [result objectForKeyedSubscript:planCoursesWillTakeMW]  ;
                 for(int i=0;i<[objCourseTaken count];i++){
                     CourseObj *obj=[[CourseObj alloc] init];
                     obj.CourseCode=[[objCourseTaken objectAtIndex:i]  objectForKeyedSubscript:planCourseCodeMW];
                     obj.CourseName=[[objCourseTaken objectAtIndex:i]  objectForKeyedSubscript:planCourseNameMW];
                    
                     obj.courseType = [[objCourseTaken objectAtIndex:i]  objectForKeyedSubscript:planCourseTypeMW];
                     
                     
                     
                     [plan.coursesTakenArr addObject:obj];
                 }
                 
                 for(int i=0;i<[objCoursewillTake count];i++){
                     CourseObj *obj=[[CourseObj alloc] init];
                     obj.CourseCode=[[objCoursewillTake objectAtIndex:i]  objectForKeyedSubscript:planCourseCodeMW];
                     obj.CourseName=[[objCoursewillTake objectAtIndex:i]  objectForKeyedSubscript:planCourseNameMW];
                     
                     obj.courseType = [[objCoursewillTake objectAtIndex:i]  objectForKeyedSubscript:planCourseTypeMW];
                     obj.currentSemester = [[[objCoursewillTake objectAtIndex:i]  objectForKeyedSubscript:planCourseCurrentSemesterMW] boolValue];
                     
                     if (obj.currentSemester == YES) {
                         [plan.coursesCurrentArr addObject:obj];
                     }
                     else
                     {
                         [plan.courseWillBeTakenArr addObject:obj];
                     }
                     
                 }
                 [dataTransfer dataLoaded:plan error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
-(void)getStudentResult:(id)delegate withStudentId:(NSString*)studentId withSemesterCode:(NSString*)semesterCode{
   // studentId=@"432201000";
    Service serv= StudentResult_WS;
    
    NSString *urlString= [NSString stringWithFormat:@"%@",[self getFullServiceString:serv] ];
//    urlString=[RequestManager addLanguageURL:urlString];
//    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"Student result url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *parameter = @{StudentID: studentId ,MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue,
                                MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang],SemesterId:semesterCode};
    
    NSLog(@"JSON parameter: %@", parameter);
    
    [manager POST:[url absoluteString]
      parameters:parameter
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             NSLog(@"JSON: %@", responseObject);
             id result = [responseObject objectForKeyedSubscript:resultResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 ResultObj *resultObj=[[ResultObj alloc] init];
                 resultObj.coursesArr=[[NSMutableArray alloc] init];
                 
                 NSDictionary* objPay =(NSDictionary*)[result objectForKeyedSubscript:resultMainObjMW]  ;
                
                 resultObj.cumGrade=[objPay objectForKeyedSubscript:resultCumGradeMW];
                 
                 resultObj.semester=[[SemesterObj alloc] init];
                 resultObj.semester.semesterName=[objPay objectForKeyedSubscript:resultSemesterNameMW];
                 resultObj.semester.semesterId=[objPay objectForKeyedSubscript:resultSemesterMW];
                 resultObj.semester.semesterGrade=[objPay objectForKeyedSubscript:resultSemesterGradeMW];

                 
                 NSArray* courses =(NSArray*) [result objectForKeyedSubscript:resultObjResultsMW]  ;
                 for(int i=0;i<[courses count];i++){
                     CourseObj *obj=[[CourseObj alloc] init];
                     obj.CourseCode=[[courses objectAtIndex:i]  objectForKeyedSubscript:resultCourseCodeMW];
                     obj.CourseName=[[courses objectAtIndex:i]  objectForKeyedSubscript:resultCourseNameMW];
                     obj.grade=[[courses objectAtIndex:i]  objectForKeyedSubscript:resultGradeDescMW];
                     [resultObj.coursesArr addObject:obj];
                 }
                 
                
                 [dataTransfer dataLoaded:resultObj error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

-(void)getStudentRecord:(id)delegate withStudentId:(NSString*)studentId{
   // studentId=@"433102837";
    Service serv= StudentRecords_WS;
    
    NSString *urlString= [NSString stringWithFormat:@"%@%@%@",[self getFullServiceString:serv] ,MWStudentIdParam,studentId];
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"Student records url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *parameter = @{StudentID: studentId ,MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue,
                                MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang]};
    NSLog(@"JSON parameter: %@", parameter);
    
    [manager POST:[url absoluteString]
      parameters:parameter
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             NSLog(@"JSON: %@", responseObject);
             id result = [responseObject objectForKeyedSubscript:recordResultMW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             NSString * accGrade=@"";
             if (operationStatus) {
                 NSMutableArray * records=[[NSMutableArray alloc]init];
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
                 
                 for(int i=0;i<[objPay count];i++){
                     RecordObj *record=[[RecordObj alloc] init];
                     record.coursesArr=[[NSMutableArray alloc] init];
                     record.semester=[[SemesterObj alloc] init];
                     record.semester.semesterId= [[objPay objectAtIndex:i]  objectForKeyedSubscript:recordSemesterIDMW];
                     record.semester.semesterName= [[objPay objectAtIndex:i]  objectForKeyedSubscript:recordSemesterNameMW];
                     record.semester.semesterGrade= [[objPay objectAtIndex:i]  objectForKeyedSubscript:recordSemesterGPAMW];
                     
                     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                     
                     if([accGrade isEqualToString:@""] && [[[objPay objectAtIndex:i] objectForKeyedSubscript:recordSemesterIDMW] isEqualToString:appDelegate.studentObj.currentSemester.semesterId] )
                     {
                         accGrade=[[objPay objectAtIndex:i]  objectForKeyedSubscript:recordCUMGPAMW];
                     }
                     BOOL found=NO;
                     for(int j=0;j<[records count];j++){
                         RecordObj* temp=[records objectAtIndex:j];
                         if([temp.semester.semesterId isEqualToString:record.semester.semesterId]){
                             found=YES;
                             record=temp;
                             break;
                         }
                     }
                     CourseObj *obj=[[CourseObj alloc] init];
                     obj.CourseCode=[[objPay objectAtIndex:i]  objectForKeyedSubscript:recordCourseCodeMW];
                     obj.CourseName=[[objPay objectAtIndex:i]  objectForKeyedSubscript:recordCourseNameMW];
                     obj.grade=[[objPay objectAtIndex:i]  objectForKeyedSubscript:recordCourseGradeMW];
                     obj.attemptedHrs=[[objPay objectAtIndex:i]  objectForKeyedSubscript:recordCourseAttemptedHrsMW];
                     
                     [record.coursesArr addObject:obj];
                     if(!found){
                         record.semester.major= [[objPay objectAtIndex:i]  objectForKeyedSubscript:recordSemesterMajorMW];
                         record.semester.status= [[objPay objectAtIndex:i]  objectForKeyedSubscript:recordSemesterStatusMW];
                         record.semester.semesterId = [[objPay objectAtIndex:i]  objectForKeyedSubscript:recordSemesterIDMW];
                         
                         [records addObject:record];
                     }
                 }
                 NSArray *lst = [[NSArray alloc] initWithObjects:records,accGrade, nil];
                 [dataTransfer dataLoaded:lst error:nil withService:serv];
             }
            else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)getStudentBorrowedBooks:(id)delegate withStudentId:(NSString *)studentId{
    //studentId=@"426108654";
    Service serv= StudentBooks_WS;
    
    NSString *urlString= [NSString stringWithFormat:@"%@%@%@",[self getFullServiceString:serv] ,bookBorrowedStudentParam,studentId];
    urlString=[RequestManager addLanguageURL:urlString];
    urlString=[RequestManager addSecretKeyURL:urlString];
    
    NSLog(@"Student Books url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager GET:[url absoluteString]
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             NSLog(@"JSON: %@", responseObject);
             id result = [responseObject objectForKeyedSubscript:bookResposeResult_MW];
             id op_result= [result objectForKeyedSubscript:ObjResultMW];
             BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
             
             if (operationStatus) {
                 NSArray* objPay =(NSArray*) [result objectForKeyedSubscript:ObjPayMW]  ;
                 
                 NSMutableArray *books= [[NSMutableArray alloc] init];
                 if(objPay && objPay!=(NSArray*)[NSNull null]){
                     for(int i=0; i<[objPay count];i++){
                         BookObj *obj=[[BookObj alloc] init];
                         
                         obj.bookName=[[objPay objectAtIndex:i] objectForKeyedSubscript:bookNameTag_MW];
                         obj.bookName= [obj.bookName stringByReplacingOccurrencesOfString:@"|c" withString:@"\n\r"];
                         obj.bookName= [obj.bookName stringByReplacingOccurrencesOfString:@"/" withString:@" "];
                         obj.bookName= [obj.bookName stringByReplacingOccurrencesOfString:@"|b" withString:@"\n\r"];
                         obj.bookName= [obj.bookName stringByReplacingOccurrencesOfString:@"=" withString:@" "];
                         [books addObject:obj];
                     }
                 }
                 [dataTransfer dataLoaded:books error:nil withService:serv];
             }else{
                 CustomError *customError = [CustomError initWithError:op_result];
                 [dataTransfer dataLoaded:nil error:customError withService:serv];
                 
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             
             // Handle failure
             NSLog(@"failed: %@",error);
             CustomError * customError = [[CustomError alloc] init];
             customError.errorMessage=ServerErrorMsg;
             [dataTransfer dataLoaded:nil error:customError withService:serv];
         }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

}

-(void)StudentChangePW:(id)delegate withUsername:(NSString*)username withOldPW:(NSString*)oldPW withNewPW:(NSString*)nPass{
    Service serv= ChangePW_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"change password url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDictionary *parameter = @{chPWUserNameMW:username,
                                chPWOldPWMW:oldPW,
                                chPWNewPWMW:nPass,
                                MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang],
                                MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue};

    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              NSLog(@"JSON success: %@", responseObject);
              id result = [responseObject objectForKeyedSubscript:chPWResultMW];
              //id op_result= [result objectForKeyedSubscript:ObjResultMW];
              BOOL operationStatus=[[result objectForKeyedSubscript:operationStatusMW] boolValue];
              
              if (operationStatus) {
                  NSString *msg=[result objectForKeyedSubscript:MWErrorMessage];
                  [dataTransfer dataLoaded:msg error:nil withService:serv];

              }else{
                  CustomError *customError = [CustomError initWithError:result];
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
                  
              }
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              // Handle failure
              NSLog(@"failed: %@",error);
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    

}

-(void)forgetPW:(id)delegate withUserName:(NSString*)username{
    Service serv= ForgetPassword_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"forget password url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDictionary *parameter = @{loginUserName_MW:username,
                                MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang],
                                MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue};
    
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              NSLog(@"JSON success: %@", responseObject);
              id result = [responseObject objectForKeyedSubscript:forgetPWResultMW];
              id op_result= [result objectForKeyedSubscript:ObjResultMW];
              BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
              
              if (operationStatus) {
                  NSString *msg=[op_result objectForKeyedSubscript:MWErrorMessage];
                  [dataTransfer dataLoaded:msg error:nil withService:serv];
                  
              }else{
                  CustomError *customError = [CustomError initWithError:op_result];
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
                  
              }
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              // Handle failure
              NSLog(@"failed: %@",error);
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    

}

-(void)forgetPWVerify:(id)delegate withUserName:(NSString*)username withVerificationCode:(NSString*)code{
    Service serv= ForgetPasswordActiv_WS;
    
    NSString *urlString=[self getFullServiceString:serv];
    
    NSLog(@"forget activation password url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDictionary *parameter = @{loginUserName_MW:username,
                                FWVerificationMW:code,
                                MWlanguagePostParam:[NSNumber numberWithInt:(int)appDelegate.currentLang],
                                MW_ScreatKeyPostParam:MW_ScreatKeyPostParamValue};
    
    
    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              NSLog(@"JSON success: %@", responseObject);
              id result = [responseObject objectForKeyedSubscript:FWVerifyResultMW];
              id op_result= [result objectForKeyedSubscript:ObjResultMW];
              BOOL operationStatus=[[op_result objectForKeyedSubscript:operationStatusMW] boolValue];
              
              if (operationStatus) {
                  NSString *msg=[op_result objectForKeyedSubscript:MWErrorMessage];
                  [dataTransfer dataLoaded:msg error:nil withService:serv];
                  
              }else{
                  CustomError *customError = [CustomError initWithError:op_result];
                  [dataTransfer dataLoaded:nil error:customError withService:serv];
                  
              }
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              // Handle failure
              NSLog(@"failed: %@",error);
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    

}

-(void)SendQRCode:(id)delegate withStudentNum:(NSString*)withStudentNum withCode:(NSString*)withCode{

    Service serv= ReadQR_WS;
    NSString *urlString=MW_QRURL;
    
    NSLog(@"QR url=%@",urlString);
    
    NSURL *url =  [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    DataTransfer *dataTransfer= [[DataTransfer alloc] init];
    dataTransfer.delegate = delegate;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    NSDictionary *dataDic = @{studentNumberMW_paramPost:withStudentNum,
                               codeMW_paramPost:withCode};
    
    NSDictionary *parameter = @{@"Data":dataDic};

    [manager POST:[url absoluteString]
       parameters:parameter
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              NSLog(@"JSON success: %@", responseObject);
              NSString *result = [NSString stringWithFormat:@"%i", (int)[[responseObject objectForKeyedSubscript:ErrorCodeResultMW] integerValue]];
              
              [dataTransfer dataLoaded:result error:nil withService:serv];
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
              
              // Handle failure
              NSLog(@"failed: %@",error);
              CustomError * customError = [[CustomError alloc] init];
              customError.errorMessage=ServerErrorMsg;
              [dataTransfer dataLoaded:nil error:customError withService:serv];
          }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    

}
@end
