//
//  LoginViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 6/23/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface LoginViewController :  BaseViewController<DataTransferDelegate,UIAlertViewDelegate>{
    
    UITextField *userNameTxt;
    UITextField *passwordTxt;
    
    UIImageView *userNameImg;
    UIImageView *passwordImg;
    
    UIButton *loginBtn;
    UIButton *forgetPWBtn;
    
    UIView *controlsView;
    
    UIButton *tochIDCheckBoxBtn;
    UIButton *tochIDBtn;
    BOOL useTouchID;
    NSString *userName;
    NSString *password;
}

@property (nonatomic,retain) IBOutlet UITextField *userNameTxt;
@property (nonatomic,retain) IBOutlet UITextField *passwordTxt;

@property (nonatomic,retain) IBOutlet UIImageView *userNameImg;
@property (nonatomic,retain) IBOutlet UIImageView *passwordImg;

@property (nonatomic,retain) IBOutlet UIButton *loginBtn;
@property (nonatomic,retain) IBOutlet UIButton *forgetPWBtn;


@property (nonatomic,retain) IBOutlet UIView *controlsView;


@property (nonatomic,retain) IBOutlet UIButton *tochIDCheckBoxBtn;
@property (nonatomic,retain) IBOutlet UIButton *tochIDBtn;
@property (nonatomic) BOOL useTouchID;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *password;


-(IBAction)onLoginPressed:(id)sender;
-(IBAction)onForgetPWPressed:(id)sender;



@end
