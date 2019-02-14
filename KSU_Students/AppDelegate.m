//
//  AppDelegate.m
//  KSU_Students
//
//  Created by EJ-Mac book on 6/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "AppDelegate.h"
#import "LocalizationSystem.h"
#import "MenuViewController.h"
#import "CustomNavigationController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "NSBundle+Language.h"
#import "StaticFuntions.h"
#import "LocalizationSystem.h"
#import "LocalizedMessages.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "LoginViewController.h"
#import "BaseViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize currentLang;
@synthesize pased,islogOut, canPan;
@synthesize studentObj;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     pased=NO;
    canPan=YES;
    
    [Fabric with:@[[Crashlytics class]]];
    [self SetAppLanguage];
    
    
    _uniqueUUID = [UIDevice currentDevice].identifierForVendor.UUIDString;
    

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    drawerController = [self generateControllerStack];
    self.leftController = drawerController.leftDrawerViewController;
    self.rightController = drawerController.rightDrawerViewController;
    self.centerController = drawerController.centerViewController;
    
    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                          green:173.0/255.0
                                           blue:234.0/255.0
                                          alpha:1.0];
    [self.window setTintColor:tintColor];

    self.window.rootViewController = drawerController;
    [self.window makeKeyAndVisible];
  //  drawerController.panningMode = IIViewDeckFullViewPanning;
    drawerController.centerHiddenInteractionMode=MMDrawerOpenCenterInteractionModeNone;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        UIView *addStatusBar = [[UIView alloc] init];
        addStatusBar.frame = CGRectMake(0, 0, self.window.frame.size.width, 20);
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        addStatusBar.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
        [self.window.rootViewController.view addSubview:addStatusBar];
    }
    
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        
        [[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setSemanticContentAttribute:UISemanticContentAttributeUnspecified];
        [[UIView appearanceWhenContainedIn:[UIAlertView class], nil] setSemanticContentAttribute:UISemanticContentAttributeUnspecified];
        
        
    }
    
    ProfileObj * obj= [StaticFuntions getSavedData];
    if(obj!=nil && obj.username!=nil && ![StaticFuntions isStringEmpty:obj.username])
    {
        if (obj.useTouchID) {
            
            LAContext *context = [[LAContext alloc] init];
            NSError *error2 = nil;
            
            if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error2]) {
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                        localizedReason:@"Are you the device owner?"
                                  reply:^(BOOL success, NSError *error)
                 {
                     if (error)
                     {
                         islogOut=YES;
                         [StaticFuntions clearProfileData];
                         drawerController = [self generateControllerStack];
                         self.leftController = drawerController.leftDrawerViewController;
                         self.rightController = drawerController.rightDrawerViewController;
                         self.centerController = drawerController.centerViewController;
                         self.window.rootViewController = drawerController;
                         
                         
                         
                         
                         if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                             UIView *addStatusBar = [[UIView alloc] init];
                             addStatusBar.frame = CGRectMake(0, 0, self.window.frame.size.width, 20);
                             [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                             addStatusBar.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
                             [self.window.rootViewController.view addSubview:addStatusBar];
                         }
                         
                         return;
                     }
                     if (!success) {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ErrorGeneralTitle message:@"You are not the device owner." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                         [alert show];
                     }
                     
                 }];
                
            }
        }
    }
    
//    NSString *currentCFBundleShortVersion = [NSString stringWithFormat:@"Version %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
//    NSArray *components = [currentCFBundleShortVersion componentsSeparatedByString: @"."];
//    NSString *lastString = (NSString *) [components objectAtIndex:2];
//    NSLog(@"%@", [NSString stringWithFormat:@"Version %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]);
//    
//    if ([lastString intValue] >= 4) {
//        ProfileObj * obj= [StaticFuntions getSavedData];
//        if(obj!=nil && obj.username!=nil && ![StaticFuntions isStringEmpty:obj.username])
//        {
//            if (obj.useTouchID) {
//                
//                LAContext *context = [[LAContext alloc] init];
//                NSError *error2 = nil;
//                
//                if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error2]) {
//                    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
//                            localizedReason:@"Are you the device owner?"
//                                      reply:^(BOOL success, NSError *error)
//                     {
//                         if (error)
//                         {
//                             islogOut=YES;
//                             [StaticFuntions clearProfileData];
//                             drawerController = [self generateControllerStack];
//                             self.leftController = drawerController.leftDrawerViewController;
//                             self.rightController = drawerController.rightDrawerViewController;
//                             self.centerController = drawerController.centerViewController;
//                             self.window.rootViewController = drawerController;
//                             
//                             
//                             
//                             
//                             if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
//                                 UIView *addStatusBar = [[UIView alloc] init];
//                                 addStatusBar.frame = CGRectMake(0, 0, self.window.frame.size.width, 20);
//                                 [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//                                 addStatusBar.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];
//                                 [self.window.rootViewController.view addSubview:addStatusBar];
//                             }
//                             
//                             return;
//                         }
//                         if (!success) {
//                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ErrorGeneralTitle message:@"You are not the device owner." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                             [alert show];
//                         }
//                         
//                     }];
//                    
//                }
//            }
//        }
//    } else {
//        // Force Update
//        [[[UIAlertView alloc] initWithTitle:ApplicationTitleText
//                                    message:FORCE_UPDATE_MSG
//                                   delegate:self
//                          cancelButtonTitle:nil
//                          otherButtonTitles:UPDATE_MSG, nil] show];
//    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    pased=YES;

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    pased=YES;

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     pased=NO;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - funtions

-(void) SetAppLanguage{
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@"language=%@",language);
    language=@"ar";
    [NSBundle setLanguage:language];
    currentLang=Arabic;

    if([language isEqualToString:@"en"]){
        currentLang=English;
        ICLocalizationSetLanguage(language);
    }else if([language isEqualToString:@"ar"]){
        currentLang=Arabic;
        ICLocalizationSetLanguage(language);
    }else{ // default if the device language is not form all of this
        currentLang=Arabic;
        ICLocalizationSetLanguage(@"ar");
    }
}


#pragma mark - view deck delegate
/*
- (BOOL)viewDeckController:(IIViewDeckController *)viewDeckController shouldBeginPanOverView:(UIView *)view {
    if (([NSStringFromClass([view class]) isEqualToString:@"UINavigationButton"] && [[[(id)view titleLabel] text] isEqualToString:@"bounce"] ) || !_canPan)
        return NO;
    if( [[((CustomNavigationController*)self.centerController) getTopView ] class] == [LoginViewController class]) {
        return NO;
    }
    
    if( [[((CustomNavigationController*)self.centerController) getTopView ] class] == [ForgetPWViewController class]) {
        return NO;
    }
    return YES;
}
*/


- (MMDrawerController*)generateControllerStack {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    
    MenuViewController* menuController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    CustomNavigationController *centerController = [mainStoryboard instantiateViewControllerWithIdentifier:@"CustomNavigationController"];
   
    MMDrawerController *_drawerController=[[MMDrawerController alloc]
                         initWithCenterViewController:centerController
                         leftDrawerViewController:menuController
                         rightDrawerViewController:nil];
    [_drawerController setShowsShadow:NO];
    [_drawerController setRestorationIdentifier:@"MMDrawer"];
    [_drawerController setMaximumRightDrawerWidth:200.0];
    [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    
    if(currentLang==Arabic){
        _drawerController.leftDrawerViewController=nil;
        _drawerController.rightDrawerViewController=menuController;
        [_drawerController setMaximumLeftDrawerWidth:200.0];
    }
    
    [_drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawer_Controller, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawer_Controller, drawerSide, percentVisible);
         }
     }];

    return _drawerController;
}

//- (void)launchAppStore {
//    NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/ksu-student/id545166496"];
//    NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[UIApplication sharedApplication] openURL:iTunesURL];
//        
////        if ([self.delegate respondsToSelector:@selector(harpyUserDidLaunchAppStore)]){
////            [self.delegate harpyUserDidLaunchAppStore];
////        }
//    });
//}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    [self launchAppStore];
//}

/*

- (BOOL)viewDeckController:(IIViewDeckController*)viewDeckController shouldOpenViewSide:(IIViewDeckSide)viewDeckSide {
    UINavigationController *navController = (UINavigationController*)self.centerController;
    
    if([[navController viewControllers] count] < 2) {
        return NO;
    }
    
    return YES;
}*/

-(void)switchMenuDirection{
    //MMDrawerController* drawerController =(MMDrawerController*)self.window.rootViewController;
    UIViewController* menuControler=nil;
    if(drawerController.rightDrawerViewController!=nil)
        menuControler=drawerController.rightDrawerViewController;
    else if (drawerController.leftDrawerViewController!=nil)
        menuControler=drawerController.leftDrawerViewController;
    if(menuControler==nil)return;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    if(currentLang==English){
        [drawerController setLeftDrawerViewController: [mainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"]];
        self.leftController=menuControler;
        self.rightController=nil;
        [drawerController setRightDrawerViewController:nil];
    }else{
       [ drawerController setRightDrawerViewController: [mainStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"]];//menuControler;
        self.rightController=menuControler;
        self.leftController=nil;
        [drawerController setLeftDrawerViewController: nil];
    }
}

-(void)openCloseMenu{
    if(currentLang==English){
        [drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }else{
        [drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    }
}

-(void)canOpenMenu:(BOOL)canOpen{
    if(canOpen){
        [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    }else{
        [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    }
}
@end
