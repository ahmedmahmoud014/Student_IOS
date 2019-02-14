//
//  LoginViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 6/23/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "LocalizationSystem.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "RequestManager.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "UICKeyChainStore.h"

@implementation LoginViewController {
    UICKeyChainStore *keychain;
}

@synthesize userNameTxt;
@synthesize passwordTxt;
@synthesize userNameImg;
@synthesize passwordImg;
@synthesize loginBtn;
@synthesize forgetPWBtn;
@synthesize controlsView;
@synthesize tochIDCheckBoxBtn;
@synthesize tochIDBtn;
@synthesize useTouchID;
@synthesize userName;
@synthesize password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
     self.navigationController.interactivePopGestureRecognizer.delegate=nil;
    self.navigationController.interactivePopGestureRecognizer.enabled=NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*if(IS_IPAD){
        int x= (self.view.frame.size.width- controlsView.frame.size.width)/2;
        controlsView.frame=CGRectMake(x, 450, controlsView.frame.size.width, controlsView.frame.size.height);
    }*/
    // Do any additional setup after loading the view.
    // commented until english
 //   [self showLanguageAlert];
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    ProfileObj * obj= [StaticFuntions getSavedData];
    if(!appdelegate.islogOut){
    
        if(obj==nil||obj.username==nil||[StaticFuntions isStringEmpty:obj.username])
        {
            useTouchID = obj.useTouchID;
         //   [self showLanguageAlert];
        }
        else{
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *todayDate = [formatter stringFromDate:[NSDate date]];
            
            BOOL updated = [StaticFuntions UpdateLoginDate:todayDate];
            if (updated) {
                appdelegate.studentObj=obj;
                if(appdelegate.currentLang!=obj.userLang)
                    [self onLanguagePressed:nil];
                appdelegate.currentLang=obj.userLang;
                
                UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueHomeScreen];
                [self.navigationController pushViewController:viewController animated:YES];
            }
            else
            {
                appdelegate.islogOut=YES;
                hasHome=NO;
                if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
                }else{
                    for (UIViewController *viewController in self.navigationController.viewControllers) {
                        if ([viewController class] == [LoginViewController class]) {
                            [self.navigationController popToViewController:viewController animated:NO];
                            break;
                            
                        }
                    }
                }
                [appdelegate canOpenMenu:NO];
                [StaticFuntions clearProfileData];
            }
            useTouchID = obj.useTouchID;

        }
    }
    else
    {
        if(obj!=nil)
        {
            useTouchID = obj.useTouchID;
        }
    }
    
    tochIDBtn.hidden = YES;
    tochIDCheckBoxBtn.hidden = YES;
    
    if(obj==nil||obj.username==nil||[StaticFuntions isStringEmpty:obj.username])
    {
        LAContext *context = [[LAContext alloc] init];
        NSError *error = nil;
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            
            tochIDBtn.hidden = FALSE;
            tochIDCheckBoxBtn.hidden = FALSE;
        }
    }
    
    
    if (useTouchID) {
        [tochIDCheckBoxBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-selected.png"] forState:UIControlStateNormal];
        
        if (!appdelegate.islogOut && (obj==nil||obj.username==nil||[StaticFuntions isStringEmpty:obj.username])) {
            [self callTouchFunction];
        }
    }
    else
    {
        [tochIDCheckBoxBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-empty.png"] forState:UIControlStateNormal];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark - base methods

-(void)callTouchFunction{
    ProfileObj * obj= [StaticFuntions getSavedTouchIDData];
    
    if (obj == nil) {
        [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:FingerPrintErrorText];
    }
    else
    {
        /*[[RequestManager sharedInstance] login:self withUsername:obj.username withPassword:obj.password];
         
         userName=obj.username;
         password=obj.password;
         
         [self showActivityViewer];
        */
        
        
        
        LAContext *context = [[LAContext alloc] init];
        NSError *error = nil;
        
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                    localizedReason:@"Are you the device owner?"
                              reply:^(BOOL success, NSError *error)
             {
                 
                 if (error) {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was a problem verifying your identity." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                     [alert show];
                     return;
                 }
                 if (success) {
                     [[RequestManager sharedInstance] login:self withUsername:obj.username withPassword:obj.password];
                     userName=obj.username;
                     password=obj.password;
                     [self showActivityViewer];
                     
                 } else {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ErrorGeneralTitle message:@"You are not the device owner." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                     [alert show];
                 }
                 
             }];
            
        }
    }
    
    
    
    
    
    
}

-(void)initalizeViews{
   // self.BGImage.image= [UIImage imageNamed:@"login-bg.png"];
}

-(void)locatizeLables{
    UIColor *color = [UIColor colorWithRed:21.0/255.0 green:163.0/255.0 blue:218.0/255.0 alpha:1];
    userNameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:usernameLblText attributes:@{NSForegroundColorAttributeName:color}];
    
    passwordTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:passwordLblText attributes:@{NSForegroundColorAttributeName:color}];
    
    [loginBtn setTitle:loginLblText forState:UIControlStateNormal];
    [forgetPWBtn setTitle:forgetPWLblText forState:UIControlStateNormal];
}

-(void)switchToLeftLayout{
    
    userNameTxt.textAlignment=NSTextAlignmentLeft;
    passwordTxt.textAlignment=NSTextAlignmentLeft;
    
    userNameTxt.rightViewMode= UITextFieldViewModeAlways;
    userNameTxt.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username.png"]];
    passwordTxt.rightViewMode= UITextFieldViewModeAlways;
    passwordTxt.rightView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password.png"]];
}

-(void)switchToRightLayout{
    userNameTxt.textAlignment=NSTextAlignmentRight;
    passwordTxt.textAlignment=NSTextAlignmentRight;
    
    userNameTxt.leftViewMode= UITextFieldViewModeAlways;
    userNameTxt.leftView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username.png"]];
    passwordTxt.leftViewMode= UITextFieldViewModeAlways;
    passwordTxt.leftView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password.png"]];
    
}

#pragma mark - events

-(IBAction)onFingerPrintPressed:(id)sender
{
    ProfileObj * obj= [StaticFuntions getSavedTouchIDData];
    if (useTouchID == NO) {
        useTouchID = YES;
        [tochIDCheckBoxBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-selected.png"] forState:UIControlStateNormal];

        if (obj == nil) {
            [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:FingerPrintErrorText];
        }
        else
        {
            [self callTouchFunction];
        }
    }
    else
    {
        useTouchID = NO;
        [tochIDCheckBoxBtn setBackgroundImage:[UIImage imageNamed:@"checkbox-empty.png"] forState:UIControlStateNormal];
    }
    
    AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    appdelegate.studentObj=obj;
    appdelegate.studentObj.useTouchID = useTouchID;
    [StaticFuntions UpdateFile:appdelegate.studentObj];
    
    
}


-(IBAction)onLoginPressed:(id)sender{
    [self removeKeyboard];
    if (![self validate]) return;
    
    // Check each time if 3 hours passed or not
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateStyle:NSDateFormatterLongStyle];
    [dateformatter setTimeStyle:NSDateFormatterLongStyle];
    NSDate *today = [NSDate date];
    NSLog(@"Now: %@", [dateformatter stringFromDate:today]);

    keychain = [UICKeyChainStore keyChainStoreWithService:MWServiceName];
    NSString *savedDate = keychain[@"QR_SUCCESS_TIME"];
    NSLog(@"PAST: %@", savedDate);
    NSString *currentUserName = keychain[@"CURRENT_STUDENT_NAME"];
    NSLog(@"User: %@", currentUserName);
    
    if (savedDate && ![currentUserName isEqualToString:userNameTxt.text]) {
        NSTimeInterval distanceBetweenDates = [today timeIntervalSinceDate:[dateformatter dateFromString:savedDate]];
#pragma mark - FIXME -
        // Testing for one minute NOT 3 Hours
        int hoursSuspending = 3;
        if (distanceBetweenDates > hoursSuspending * 3600) { // hoursSuspending * 3600 --> 60 seconds = 1 minute for Testing
            [[RequestManager sharedInstance] login:self withUsername:userNameTxt.text withPassword:passwordTxt.text];
            userName=userNameTxt.text;
            password=passwordTxt.text;

            [self showActivityViewer];
        } else {
            NSLog(@"Not Available NOW");
            [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:ACCESS_DENIED_MSG];
        }
    }
    else {
        [[RequestManager sharedInstance] login:self withUsername:userNameTxt.text withPassword:passwordTxt.text];
        userName=userNameTxt.text;
        password=passwordTxt.text;
        
        [self showActivityViewer];
    }
}

-(IBAction)onForgetPWPressed:(id)sender{
    [self removeKeyboard];
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueForgetPWScreen];
    [self.navigationController pushViewController:viewController animated:YES];
    
}


-(IBAction)onLanguagePressed:(id)sender{
    
    [self setAppLanguage];
    [self locatizeLables];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English){
        [self switchToLeftLayout];
    }else{
        [self switchToRightLayout];
    }
    
}

#pragma mark - touch delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([passwordTxt isFirstResponder] && [touch view] != passwordTxt) {
        [passwordTxt resignFirstResponder];
    }
    if ([userNameTxt isFirstResponder] && [touch view] != userNameTxt) {
        [userNameTxt resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

#pragma mark - methods

-(void)removeKeyboard{
    [passwordTxt resignFirstResponder];
    [userNameTxt resignFirstResponder];
}

-(BOOL)validate{
    if([StaticFuntions isStringEmpty:userNameTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:userNameMandatoryMsg];
        return NO;
    }else if([StaticFuntions isStringEmpty:passwordTxt.text]){
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:passwordMandatoryMsg];
        return NO;
    }
    return YES;
}

-(void) setAppLanguage{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *language=@"";
    if(delegate.currentLang==Arabic){
        language=@"en";
        delegate.currentLang=English;
    }else if(delegate.currentLang==English){
        language= @"ar";
        delegate.currentLang=Arabic;
    }
    
    ICLocalizationSetLanguage(language);
    
    [delegate switchMenuDirection];
    
}
-(void)showLanguageAlert{
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:ApplicationTitleText message:changeLangMsgText delegate:self cancelButtonTitle:CancelButtonText otherButtonTitles:OKayButtonText, nil];
    [alert show];
}
#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
   [self hideActivityViewer];
    if(data!=nil){
        AppDelegate *appdelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        appdelegate.studentObj=(ProfileObj*)data;
        appdelegate.studentObj.userLang=appdelegate.currentLang;
        appdelegate.studentObj.username=userName;
        appdelegate.studentObj.password=password;
        appdelegate.studentObj.useTouchID=useTouchID;
        appdelegate.islogOut=NO;
        //appdelegate.studentObj.empDeviceToken=appdelegate.deviceToken;
        [StaticFuntions createFile:appdelegate.studentObj];
        if (useTouchID) {
            
            ProfileObj * obj= [StaticFuntions getSavedTouchIDData];
            if (obj == nil)
            {
                [StaticFuntions createTouchIDFile:appdelegate.studentObj];
            }
        }
        
        keychain = [UICKeyChainStore keyChainStoreWithService:MWServiceName];
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateStyle:NSDateFormatterLongStyle];
        [dateformatter setTimeStyle:NSDateFormatterLongStyle];
        NSDate *today = [NSDate date];
        NSLog(@"%@", [dateformatter stringFromDate:today]);
        // Here we should save date and check each time in home if 3 hours passed or not
        [keychain setString:[dateformatter stringFromDate:today] forKey:@"QR_SUCCESS_TIME"];
        [keychain setString:appdelegate.studentObj.username forKey:@"CURRENT_STUDENT_NAME"];
        
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
        return;
    }
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueHomeScreen];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark- alert delegate

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0)return;
    
    [self showActivityViewer];
    [self onLanguagePressed:nil];
    [self hideActivityViewer];
    [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:changeLangDoneMsgText];
    
}
@end
