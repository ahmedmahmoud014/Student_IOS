//
//  StaticVariables.h
//  KSU_Students
//
//  Created by EJ-Mac book on 6/7/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#ifndef KSU_Students_StaticVariables_h
#define KSU_Students_StaticVariables_h

typedef NS_ENUM( NSUInteger, MyLanguages ){
    Arabic=0,
    English=1
};

typedef NS_ENUM( NSUInteger, Service ){
    Login_WS=0,
    StudentProfile_WS,
    StudentRewards_WS,
    StudentTransaction_WS,
    Student_Loan_WS,
    StudentSchedule_WS,
    StudentPlan_WS,
    StudentResult_WS,
    StudentRecords_WS,
    StudentBooks_WS,
    ChangePW_WS,
    ForgetPassword_WS,
    ForgetPasswordActiv_WS,
    ReadQR_WS
};

typedef NS_ENUM( NSUInteger, CURRENT_WEEK_TAB ){
    WEEK_SCHEDULE=0,
    OTHERS
    
};

////////////////////////////////////constant/////////////////////////////////////
#define NumberMenuItems                             4
#define minPWLenght                                 6
//////////////////////////////////////////////////////////////////////////////////

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? YES : NO)


/////////////////////////////////////////////////////////////////
//////////////////////View Seague constants///////////////////////
//////////////////////////////////////////////////////////////////
#define SeagueLoginScreen                          @"LoginViewController"
#define SeagueHomeScreen                           @"HomeViewController"
#define SeagueForgetPWScreen                       @"ForgetPWViewController"
#define SeagueProfileScreen                        @"ProfileViewController"
#define SeagueRewardsScreen                        @"RewardsViewController"
#define SeagueTransactionsScreen                   @"TransactionsViewController"
#define SeagueLoansScreen                          @"LoansViewController"
#define SeagueScheduleScreen                       @"ScheduleViewController"
#define SeaguePlanScreen                           @"PlanViewController"
#define SeagueResultScreen                         @"ResultViewController"
#define SeagueRecordsScreen                        @"RecordsViewController"
#define SeagueBooksScreen                          @"BooksViewController"
#define SeagueCalendarScreen                       @"CalendarViewController"
#define SeagueAboutScreen                          @"AboutViewController"
#define SeagueChangePWScreen                       @"ChangePWViewController"
#define SeagueQRScreen                             @"QrViewController"
///////////////////////////Services general/////////////////////////////////

#define MW_URL                                     @"https://mobileapi.ksu.edu.sa/StudentMobilePOST/"
#define MW_URLBooks                                @"https://mobileapi.ksu.edu.sa/MobileAppData.svc/"
#define MWServiceName                              @"StudentMobile.svc/"
#define MW_QRURL                                   @"http://212.57.195.216/api/qrcode/submit"
#define MW_ScreatKeyParam                          @"SKey=943D4D1F-E067-4534-B80A-D5618D38C213"
#define MW_ScreatKeyParamWithout                   @"SKey=943D4D1FE0674534B80AD5618D38C213"

#define MW_ScreatKeyPostParamValue                 @"943D4D1F-E067-4534-B80A-D5618D38C213"
#define MW_ScreatKeyPostParam                      @"SKey"
#define MW_GeneralDel                              @"&"
#define MWErrorMessage                             @"Message"
#define MWlanguageParam                            @"Language="
#define MWlanguagePostParam                        @"Language"
#define operationStatusMW                          @"OperationStatus"
#define ObjPayMW                                   @"objPay"
#define ObjResultMW                                @"objResult"
#define MWStudentIdParam                           @"StudentId="
#define studentNumberMW_paramPost                  @"StudentNumber"
#define codeMW_paramPost                           @"Code"
#define StudentID                                  @"StudentId"


///////////////////////////////////web service////////////////////////////
#define MW_LoginWS                                  @"StudentAuthentication"
#define MW_StudentProfile_WS                        @"StudentProfile"
#define MW_StudentRewards_WS                        @"StudentRewards"
#define MW_StudentTransaction_WS                    @"AcademicTransactions"
#define MW_StudentLoans_WS                          @"StudentLoan"
#define MW_StudentSchedule_WS                       @"StudentSchedule"
#define MW_StudentPlan_WS                           @"StudentStudyPlan"
#define MW_StudentResult_WS                         @"SemesterResults"
#define MW_StudentRecords_WS                        @"AcademicRecords"
#define MW_StudentBooks_WS                          @"GetStudentBooksData?"
#define MW_ChangePW_WS                              @"ChangePassword"
#define MW_ForgetPassword_WS                        @"ForgetPassword"
#define MW_ForgetPasswordActiv_WS                   @"ForgetPasswordVerification"
//////////////////////////////login /////////////////////////////////////
#define loginUserName_MW                            @"UserName"
#define loginPassword_MW                            @"Password"
#define loginResults_MW                             @"StudentAuthenticationResult"
#define StudentId_MW                                @"StudentID"
#define currentSemesterMW                           @"CurrentSemester"
#define semesterIdMW                                @"SemesterId"
#define semesterNameMW                              @"SemesterName"
#define semesterObjLstMW                            @"objSem"
/////////////////////////profile////////////////////////////////////////
#define profileResultMW                             @"StudentProfileResult"
#define profileDegreeMW                             @"Degree"
#define profileEmailMW                              @"Email"
#define profileFacultyMW                            @"Faculty"
#define profileGenderMW                             @"Gender"
#define profileIsMaleMW                             @"IsMale"
#define profileMajorMW                              @"Major"
#define profileNationalIdMW                         @"NationalId"
#define profileNationalityMW                        @"Nationality"
#define profileStatusMW                             @"Status"
#define profileStudentIdMW                          @"StudentId"
#define profileStudentNameMW                        @"StudentName"
#define profileTelNoMW                              @"TelNo"
//////////////////////////rewards//////////////////////////////////
#define rewardsResultMW                             @"StudentRewardsResult"
#define rewardsDetailsMW                            @"ITEM_DESC"
#define rewardsDateMW                               @"Date"
#define rewardsAmountMW                             @"AMOUNT"
////////////////////////////Transaction///////////////////////////
#define transactionResultMW                         @"AcademicTransactionsResult"
#define transactionCourseNameMW                     @"ClassName"
#define transactionStatusMW                         @"Status_Desc"
#define transactionDetailsMW                        @"COURSE_DESC"
////////////////////////////loans///////////////////////////
#define loanResultMW                                @"StudentLoanResult"
#define loanCourseYearMW                            @"SEMESTER_DESC"
#define loanTypeMW                                  @"LOAN_TYPE_DESC"
#define loanAmountMW                                @"AMOUNT"
/////////////////////////schedule///////////////////////////
#define scheduleResultMW                            @"StudentScheduleResult"

#define scheduleClassbuildingIdMW                   @"BuildingNo"
#define scheduleClassPartitionIdMW                  @"Partition"
#define scheduleClassinstractorIdMW                 @"InstructorName"
#define scheduleClassJobTitleMW                     @"JobTitle"
#define scheduleClassfloorIdMW                      @"Floor"
#define scheduleClassroomIdMW                       @"CLASSROOM_ID"

#define scheduleCourseCodeMW                        @"COURSE_CODE"
#define scheduleDayMW                               @"DAY"
#define scheduleEndTimeMW                           @"END_TIME"
#define scheduleFromTimeMW                          @"FROM_TIME"
#define scheduleSectionIDMW                         @"Section_ID"
/////////////////////////////////Plan//////////////////////////////
#define planResultMW                                @"StudentStudyPlanResult"
#define planCoursesTakenMW                          @"objCourseTaken"
#define planCoursesWillTakeMW                       @"objCourseWilltaken"
#define planCourseCodeMW                            @"COURSE_CODE"
#define planCourseNameMW                            @"COURSE_NAME"
#define planCourseTypeMW                            @"PlanType"
#define planCourseCurrentSemesterMW                 @"CurrentSemester"
////////////////////////////////Result////////////////////////////
#define resultResultMW                              @"SemesterResultsResult"
#define resultMainObjMW                             @"objMain"
#define resultCumGradeMW                            @"CUM_GPA"
#define resultSemesterMW                            @"Semester"
#define resultSemesterGradeMW                       @"Semester_GPA"
#define resultObjResultsMW                          @"objResults"
#define resultCourseCodeMW                          @"Course_Code"
#define resultGradeDescMW                           @"Grade_Desc"
#define resultSemesterNameMW                        @"SemesterName"
#define resultCourseNameMW                          @"Course_Name"
#define resultSemesterParamMW                       @"SemesterId="
#define SemesterId                       @"SemesterId"

////////////////////////////Records/////////////////////////////////
#define recordResultMW                              @"AcademicRecordsResult"
#define recordCourseCodeMW                          @"Course_Code"
#define recordCourseNameMW                          @"Course_Name"
#define recordSemesterIDMW                          @"SemesterId"
#define recordSemesterNameMW                        @"Semester_Desc"
#define recordSemesterStatusMW                      @"Semester_Status_Desc"
#define recordSemesterMajorMW                       @"Semester_Major_Name"
#define recordSemesterGPAMW                         @"Semester_GPA"
#define recordCUMGPAMW                              @"Cum_GPA"
#define recordCourseGradeMW                         @"Grade_Desc"
#define recordCourseAttemptedHrsMW                  @"Attempted_Hrs"
////////////////////////book borrowed///////////////////////////////////////////////
#define bookResposeResult_MW                       @"GetStudentBooksDataResult"
#define bookBorrowedStudentParam                   @"RequesterId="
#define bookNameTag_MW                             @"BookTagName"
///////////////////////////////////calendar/////////////////////////////////////
#define calendarListJson                           @"calendar"
#define calendarTypeJson                           @"v_type"
#define calendarHijriJson                          @"hijriDate"
#define calendarGreogJson                          @"greogDate"
///////////////////////////////////Change password/////////////////////////////
#define chPWUserNameMW                              @"UserName"
#define chPWOldPWMW                                 @"OldPassword"
#define chPWNewPWMW                                 @"NewPassword"
#define chPWResultMW                                @"ChangePasswordResult"
//////////////////////////forget password//////////////////////////////////////////
#define forgetPWResultMW                           @"ForgetPasswordResult"
#define FWVerificationMW                           @"VerificationCode"
#define FWVerifyResultMW                           @"ForgetPasswordVerificationResult"
//////////////////////////forget password//////////////////////////////////////////
#define ErrorCodeResultMW                          @"ErrorCode"


#endif
