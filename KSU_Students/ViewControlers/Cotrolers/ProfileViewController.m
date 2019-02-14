//
//  ProfileViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 7/22/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "ProfileViewController.h"
#import "RequestManager.h"
#import "AppDelegate.h"
#import "StaticFuntions.h"
#import "LocalizedMessages.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize profileImg;
@synthesize nameLbl;
@synthesize studentIdLbl;
@synthesize studentIdValLbl;
@synthesize telNoLbl;
@synthesize telNoValLbl;
@synthesize facultyLbl;
@synthesize facultyValLbl;
@synthesize specializeLbl;
@synthesize specializeValLbl;
@synthesize statusLbl;
@synthesize statusValLbl;
@synthesize emailLbl;
@synthesize emailValLbl;
@synthesize nationalIdLbl;
@synthesize nationalIdValLbl;
@synthesize nationalityLbl;
@synthesize nationalityValLbl;
@synthesize degreeLbl;
@synthesize degreeValLbl;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - base methods

-(void)initalizeViews{

    [self connect];
}

-(void)locatizeLables{
    self.navigationItem.title=profileTitleText;
    telNoLbl.text=profileTelNoText;
    studentIdLbl.text=profileStudentIdText;
    facultyLbl.text=profileFacultyText;
    specializeLbl.text=profileMajorText;
    degreeLbl.text=profileDegreeText;
    emailLbl.text=profileEmailText;
    statusLbl.text=profileStatusText;
    nationalityLbl.text=profileNationalityText;
    nationalIdLbl.text=profileNationalIdText;
}

-(void)switchToLeftLayout{
     NSTextAlignment align=NSTextAlignmentLeft;
    nameLbl.textAlignment=align;
    telNoValLbl.textAlignment=align;
    studentIdValLbl.textAlignment=align;
    facultyValLbl.textAlignment=align;
    specializeValLbl.textAlignment=align;
    degreeValLbl.textAlignment=align;
    emailValLbl.textAlignment=align;
    statusValLbl.textAlignment=align;
    nationalIdValLbl.textAlignment=align;
    nationalityValLbl.textAlignment=align;
    
    telNoLbl.textAlignment=align;
    studentIdLbl.textAlignment=align;
    facultyLbl.textAlignment=align;
    specializeLbl.textAlignment=align;
    degreeLbl.textAlignment=align;
    emailLbl.textAlignment=align;
    statusLbl.textAlignment=align;
    nationalityLbl.textAlignment=align;
    nationalIdLbl.textAlignment=align;
}

-(void)switchToRightLayout{
    NSTextAlignment align=NSTextAlignmentRight;
    
    nameLbl.textAlignment=align;
    telNoValLbl.textAlignment=align;
    studentIdValLbl.textAlignment=align;
    facultyValLbl.textAlignment=align;
    specializeValLbl.textAlignment=align;
    degreeValLbl.textAlignment=align;
    emailValLbl.textAlignment=align;
    statusValLbl.textAlignment=align;
    nationalIdValLbl.textAlignment=align;
    nationalityValLbl.textAlignment=align;
    
    telNoLbl.textAlignment=align;
    studentIdLbl.textAlignment=align;
    facultyLbl.textAlignment=align;
    specializeLbl.textAlignment=align;
    degreeLbl.textAlignment=align;
    emailLbl.textAlignment=align;
    statusLbl.textAlignment=align;
    nationalityLbl.textAlignment=align;
    nationalIdLbl.textAlignment=align;
}

#pragma mark - methods

-(void)connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getStudentProfile:self withStudentId:appDelegate.studentObj.studentId];
    
    [self showActivityViewer];
}

-(void) fillData{
    if(pObj.studentGender==Female){
        profileImg.image=[UIImage imageNamed:@"student_img_f.png"];
    }else{
         profileImg.image=[UIImage imageNamed:@"student_img.png"];
    }
    nameLbl.text=pObj.name;
    telNoValLbl.text=pObj.telNo;
    studentIdValLbl.text=pObj.studentId;
    facultyValLbl.text=pObj.faculty;
    specializeValLbl.text=pObj.specialize;
    degreeValLbl.text=pObj.degree;
    emailValLbl.text=pObj.email;
    statusValLbl.text=pObj.status;
    nationalIdValLbl.text=pObj.nationalId;
    nationalityValLbl.text=pObj.nationality;
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        if([service intValue]==(int)StudentProfile_WS){
            pObj=(ProfileObj*)data;
            [self fillData];
        }
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
}
@end
