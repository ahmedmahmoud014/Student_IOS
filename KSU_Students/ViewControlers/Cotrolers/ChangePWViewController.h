//
//  ChangePWViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/14/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface ChangePWViewController : BaseViewController<UITextFieldDelegate,DataTransferDelegate>{
    UITextField *oldPassTxt;
    
    UITextField *nPassTxt;
    
    UITextField *confirmPassTxt;
    
    UILabel *usernameLbl;
    UITextField *usernameTxt;
    
    UIButton *doneBtn;
    UIButton *cancelBtn;
    UIView *controlsView;
    

    UIView *oldPassView;
    UIView *nPassView;
    UIView *confirmPassView;
}

@property(nonatomic,retain) IBOutlet UITextField *oldPassTxt;

@property(nonatomic,retain) IBOutlet UITextField *nPassTxt;

@property(nonatomic,retain) IBOutlet UITextField *confirmPassTxt;

@property(nonatomic,retain) IBOutlet UILabel *usernameLbl;
@property(nonatomic,retain) IBOutlet UITextField *usernameTxt;

@property(nonatomic,retain) IBOutlet UIButton *doneBtn;
@property(nonatomic,retain) IBOutlet UIButton *cancelBtn;

@property(nonatomic,retain) IBOutlet UIView *controlsView;
@property(nonatomic,retain) IBOutlet UIView *oldPassView;
@property(nonatomic,retain) IBOutlet UIView *nPassView;
@property(nonatomic,retain) IBOutlet UIView *confirmPassView;

-(IBAction)onDonePressed:(id)sender;
-(IBAction)onCancelPressed:(id)sender;



@end
