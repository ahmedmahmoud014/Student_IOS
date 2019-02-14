//
//  AppDelegate.h
//  KSU_Students
//
//  Created by EJ-Mac book on 6/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaticVariables.h"
#import "MMDrawerController.h"
#import "ProfileObj.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>{
    BOOL pased;
    MyLanguages currentLang;
    BOOL islogOut;
    ProfileObj *studentObj;
    MMDrawerController* drawerController;
}

@property (nonatomic)MyLanguages currentLang;
@property (nonatomic) BOOL pased;
@property (nonatomic) BOOL islogOut;
@property (nonatomic, readwrite) BOOL canPan;
@property (nonatomic) NSString *uniqueUUID;

@property (strong, nonatomic) UIWindow *window;

@property (retain, nonatomic) UIViewController *centerController;
@property (retain, nonatomic) UIViewController *leftController;
@property (retain, nonatomic) UIViewController *rightController;

@property (retain, nonatomic) ProfileObj *studentObj;


- (MMDrawerController*)generateControllerStack;

-(void) switchMenuDirection;

-(void)openCloseMenu;
-(void)canOpenMenu:(BOOL)canOpen;

@end

