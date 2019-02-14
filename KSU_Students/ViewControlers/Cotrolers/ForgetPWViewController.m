//
//  ForgetPWViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 7/20/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "ForgetPWViewController.h"
#import "LocalizedMessages.h"
#import "RequestManager.h"
#import "StaticFuntions.h"

@interface ForgetPWViewController ()

@end

@implementation ForgetPWViewController
@synthesize usernameTxt,usernameView;
@synthesize titleLbl;
@synthesize doneBtn,cancelBtn;
@synthesize pleaseLbl;
@synthesize controlsView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*if(IS_IPAD){
        int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
        controlsView.frame=CGRectMake(x, controlsView.frame.origin.y, controlsView.frame.size.width, controlsView.frame.size.height);
    }*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate=nil;
    //self.navigationController.interactivePopGestureRecognizer.enabled=NO;
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
}

-(void)locatizeLables{
    titleLbl.text=forgetPWLblText;
    
    UIColor *color = [UIColor colorWithRed:21.0/255.0 green:163.0/255.0 blue:218.0/255.0 alpha:1];
    
    if(isActiveCode){
        usernameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:forgetPWVerifyText attributes:@{NSForegroundColorAttributeName:color}];
        [doneBtn setTitle:VerifyButtonText forState:UIControlStateNormal];
        
        pleaseLbl.text=pleaseFillFWCodeMsg;
    }else{
        usernameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:usernameLblText attributes:@{NSForegroundColorAttributeName:color}];
        [doneBtn setTitle:SendButtonText forState:UIControlStateNormal];
        
        pleaseLbl.text=pleaseFillFWDataMsg;
    }
    [cancelBtn setTitle:CancelButtonText forState:UIControlStateNormal];
  
}

-(void)switchToLeftLayout{
    
    NSTextAlignment align=NSTextAlignmentLeft;
  //  titleLbl.textAlignment=align;
    
    pleaseLbl.textAlignment=align;
    
    usernameTxt.textAlignment=align;
    
    usernameTxt.rightViewMode= UITextFieldViewModeAlways;
    usernameTxt.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username.png"]];
}

-(void)switchToRightLayout{
    NSTextAlignment align=NSTextAlignmentRight;
   // titleLbl.textAlignment=align;
    
    pleaseLbl.textAlignment=align;
    
    usernameTxt.textAlignment=align;
    
    usernameTxt.leftViewMode= UITextFieldViewModeAlways;
    usernameTxt.leftView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username.png"]];
  
}



#pragma mark - touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([usernameTxt isFirstResponder] && [touch view] != usernameTxt) {
        [usernameTxt resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - events

-(IBAction)onDonePressed:(id)sender{
    [self hideKeyboard];
    if(![self validate])return;
    [self connect];
}
-(IBAction)onCancelPressed:(id)sender{
    [self hideKeyboard];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - methods

-(BOOL)validate{
    if([StaticFuntions isStringEmpty:usernameTxt.text]){
        if(isActiveCode)
            [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:verifyCodeMandatoryFPMsg];
        else
            [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:userNameMandatoryFPMsg];
        return NO;
    }
    return YES;
}
-(void)dummyData{
    
}


-(void)hideKeyboard{
    [usernameTxt resignFirstResponder];
    
}

-(void)connect{
    if(isActiveCode){
        [[RequestManager sharedInstance] forgetPWVerify:self withUserName:enteredUserName withVerificationCode:usernameTxt.text];
    }else
        [[RequestManager sharedInstance] forgetPW:self withUserName:usernameTxt.text];
    [self showActivityViewer];
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(error==nil){
        if([service intValue]==(int)ForgetPassword_WS){
            [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:verificationSendingMsg];
            isActiveCode=YES;
            enteredUserName=usernameTxt.text;
            usernameTxt.text=@"";
            [self locatizeLables];
            
        }else{
            [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:forgetPWDoneMsg];
            [self onCancelPressed:nil];
        }
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
}



@end
