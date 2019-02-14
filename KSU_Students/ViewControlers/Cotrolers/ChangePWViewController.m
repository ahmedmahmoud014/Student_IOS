//
//  ChangePWViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/14/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "ChangePWViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "AppDelegate.h"
#import "RequestManager.h"

@interface ChangePWViewController ()

@end

@implementation ChangePWViewController
@synthesize oldPassTxt,oldPassView;
@synthesize nPassTxt,nPassView;
@synthesize confirmPassTxt,confirmPassView;
@synthesize cancelBtn,doneBtn;
@synthesize controlsView;
@synthesize usernameLbl,usernameTxt;

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

    [self initBGViews];
}

-(void)locatizeLables{
    self.navigationItem.title=MenuChangePWText;
    usernameLbl.text=usernameLblText;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    usernameTxt.text=appDelegate.studentObj.username;
    
    UIColor *color =[UIColor colorWithRed:21.0/255.0 green:163.0/255.0 blue:218.0/255.0 alpha:1];
    
    oldPassTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:ChPwOldPwText attributes:@{NSForegroundColorAttributeName:color}];
    nPassTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:ChPwNewPwText attributes:@{NSForegroundColorAttributeName:color}];
    confirmPassTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:ChPwConfirmPWText attributes:@{NSForegroundColorAttributeName:color}];
    
    [cancelBtn setTitle:CancelButtonText forState:UIControlStateNormal];
    [doneBtn setTitle:VerifyButtonText forState:UIControlStateNormal];
    
}

-(void)switchToLeftLayout{
    
    NSTextAlignment align=NSTextAlignmentLeft;

   // usernameTxt.textAlignment=align;
    usernameLbl.textAlignment=align;
    
    oldPassTxt.textAlignment=align;
    nPassTxt.textAlignment=align;
    confirmPassTxt.textAlignment=align;
    
}

-(void)switchToRightLayout{
    NSTextAlignment align=NSTextAlignmentRight;
    
    //usernameTxt.textAlignment=align;
    usernameLbl.textAlignment=align;
    
    oldPassTxt.textAlignment=align;
    nPassTxt.textAlignment=align;
    confirmPassTxt.textAlignment=align;
    
}



#pragma mark - touch delegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([oldPassTxt isFirstResponder] && [touch view] != oldPassTxt) {
        [oldPassTxt resignFirstResponder];
    }
    if ([nPassTxt isFirstResponder] && [touch view] != nPassTxt) {
        [nPassTxt resignFirstResponder];
    }
    
    if ([confirmPassTxt isFirstResponder] && [touch view] != confirmPassTxt) {
        [confirmPassTxt resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - events

-(IBAction)onDonePressed:(id)sender{
    [self hideKeyboard];
    if([self validate])
        [self connect];
    
}
-(IBAction)onCancelPressed:(id)sender{
    [self hideKeyboard];
    [self onHomePressed:self];
}

#pragma mark - methods

-(void)initBGViews{
  //  usernameTxt.layer.borderWidth=0.5;
   // usernameTxt.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    oldPassView.layer.borderWidth=0.5;
    nPassView.layer.borderWidth=0.5;
    confirmPassView.layer.borderWidth=0.5;
    
    oldPassView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    nPassView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    confirmPassView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
}

-(void)hideKeyboard{
    [oldPassTxt resignFirstResponder];
    [nPassTxt resignFirstResponder];
    [confirmPassTxt resignFirstResponder];
}

-(void)connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] StudentChangePW:self withUsername:appDelegate.studentObj.username withOldPW:oldPassTxt.text withNewPW:nPassTxt.text];
    
    [self showActivityViewer];
}

-(BOOL)validate{
    if([StaticFuntions isStringEmpty:oldPassTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:passwordMandatoryChMsg];
        return NO;
    }else if([StaticFuntions isStringEmpty:nPassTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:newPWMandatoryMsg];
        return NO;
    }else if([StaticFuntions isStringEmpty:confirmPassTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:confirmPWMandatoryMsg];
        return NO;
    }else if(oldPassTxt.text.length<minPWLenght){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:PWminLenghtMsgText];
        return NO;
    }else if(nPassTxt.text.length<minPWLenght){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:PWminLenghtMsgText];
        return NO;
    }else if(![nPassTxt.text isEqualToString :confirmPassTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:confirmPW_notMatchMsg];
        return NO;
    }else if([nPassTxt.text isEqualToString :oldPassTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:confirmOldPWMatchMsg];
        return NO;
    }
    return YES;
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(error==nil){
        [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:ChangePWDoneMsgText];
        
        UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueHomeScreen];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
}
@end
