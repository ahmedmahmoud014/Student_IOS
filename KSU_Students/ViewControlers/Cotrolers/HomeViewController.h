//
//  HomeViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 6/29/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController{
    
}

- (NSUInteger)getCountOfSemester;

@property(nonatomic,retain) IBOutlet UILabel *titleLbl;

@property(nonatomic,retain) IBOutlet UIButton *acdTransBtn;
@property(nonatomic,retain) IBOutlet UIButton *acdRecordsBtn;
@property(nonatomic,retain) IBOutlet UIButton *booksBtn;
@property(nonatomic,retain) IBOutlet UIButton *calendarBtn;
@property(nonatomic,retain) IBOutlet UIButton *loansBtn;
@property(nonatomic,retain) IBOutlet UIButton *resultBtn;
@property(nonatomic,retain) IBOutlet UIButton *attendanceBtn;
@property(nonatomic,retain) IBOutlet UIButton *rewardsBtn;
@property(nonatomic,retain) IBOutlet UIButton *scheduleBtn;
@property(nonatomic,retain) IBOutlet UIButton *profileBtn;
@property(nonatomic,retain) IBOutlet UIButton *planBtn;

-(IBAction)onProfilePressed:(id)sender;
-(IBAction)onRewardsPressed:(id)sender;
-(IBAction)onTransactionsPressed:(id)sender;
-(IBAction)onLoansPressed:(id)sender;

-(IBAction)onSchedulePressed:(id)sender;
-(IBAction)onPlanPressed:(id)sender;
-(IBAction)onResultPressed:(id)sender;
-(IBAction)onAttendancePressed:(id)sender;
-(IBAction)onRecordPressed:(id)sender;

-(IBAction)onBooksPressed:(id)sender;
-(IBAction)onCalendarPressed:(id)sender;

@end
