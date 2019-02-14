//
//  CustomNavigationController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 6/23/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "CustomNavigationController.h"
#import "AppDelegate.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushAsRootView:(UIViewController *)viewController   {
    
    /* for (UIViewController *viewController in self.viewControllers) {
     if ([viewController class] == [RootViewController class]) {
     [self popToViewController:viewController animated:NO];
     break;
     
     }
     }
     [self pushViewController:viewController animated:YES];*/
}


-(UIViewController*)getTopView{
    return self.topViewController;
}
- (void)pushAsView:(UIViewController *)viewController   {
    
    [self pushViewController:viewController animated:YES];
}
/*
 - (void)loadFirstTime   {
 for (UIViewController *viewController in self.viewControllers) {
 if ([viewController class] == [RootViewController class]) {
 [self popToViewController:viewController animated:YES];
 //RootViewController *root =  (RootViewController *)viewController;
 //[root initializeInvitationsDownloading];
 return;
 
 }
 }
 
 }
 */

- (void)setPanning:(BOOL)allow  {
   AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setCanPan:allow];
}
@end

