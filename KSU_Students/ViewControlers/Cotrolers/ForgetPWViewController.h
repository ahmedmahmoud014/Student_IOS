//
//  ForgetPWViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/20/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "ForgetPWObj.h"

@interface ForgetPWViewController : BaseViewController <UITextFieldDelegate,DataTransferDelegate>{

    UILabel *pleaseLbl;

    UITextField *usernameTxt;
    UIView *usernameView;
    
    UILabel *titleLbl;
    
    UIButton *doneBtn;
    UIButton *cancelBtn;
    ForgetPWObj *FPWObj;
    bool isActiveCode;
    NSString *enteredUserName;
    UIView *controlsView;
}

@property(nonatomic,retain) IBOutlet UITextField *usernameTxt;
@property(nonatomic,retain) IBOutlet UIView *usernameView;

@property(nonatomic,retain) IBOutlet UILabel *pleaseLbl;


@property(nonatomic,retain) IBOutlet UILabel *titleLbl;

@property(nonatomic,retain) IBOutlet UIButton *doneBtn;
@property(nonatomic,retain) IBOutlet UIButton *cancelBtn;

@property(nonatomic,retain) IBOutlet UIView *controlsView;

-(IBAction)onDonePressed:(id)sender;
-(IBAction)onCancelPressed:(id)sender;


@end
