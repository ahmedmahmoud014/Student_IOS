//
//  BaseViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 6/28/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "StaticVariables.h"
#import "CustomNavigationController.h"
#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "StaticFuntions.h"
#import "HomeViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize BGImage;
@synthesize noDataLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - view events
- (void)viewDidLoad{
    [super viewDidLoad];
//    BGImage.image=[UIImage imageNamed:@"bg.png"];

    [self initalizeViews];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self switchLayout];
    [self locatizeLables];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(delegate.pased)
        [self refreshView];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if(hasHome){
        //[self goBack:nil];
        return self.navigationController.viewControllers.count > 2 &&
        !self.navigationController.navigationBarHidden ;
        //return YES;
    }
    return NO;
    
}


- (void)customizeNavigationBar:(BOOL)withHome WithMenu:(BOOL)withMenu   {
    
    hasHome=withHome;
    if ([self.navigationController respondsToSelector:@selector(setPanning:)]) {
        CustomNavigationController * navigation = (CustomNavigationController *)self.navigationController;
        [navigation setPanning:withMenu];
    }
    ///self.navigationController.interactivePopGestureRecognizer.enabled=withHome;
    ///if(withHome){
       //// self.navigationController.interactivePopGestureRecognizer.delegate=self;
    ////}
    //  self.navigationController.interactivePopGestureRecognizer

 /*  UIPanGestureRecognizer *pan= [[UIPanGestureRecognizer alloc]
     initWithTarget:self.navigationController.interactivePopGestureRecognizer
     action:@selector(goBack:)];
   */ 
    self.navigationController.navigationBar.hidden = NO;
    
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -1.0) forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeTop;
    
    self.navigationItem.hidesBackButton = YES;
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    
    [[[self navigationController] navigationBar] setTintColor:[self getMainColor]];
    
    UIFont *f= [UIFont boldSystemFontOfSize:15.0];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys: f,
        NSFontAttributeName,nil]];
    
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (withMenu) {
        [appDelegate canOpenMenu:YES];
        UIButton *menubarButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 46, 15, 36, 36)];
        [menubarButton setImage:[UIImage imageNamed:@"menuBtn"] forState:UIControlStateNormal];
        //[menubarButton setImage:[UIImage imageNamed:@"menu_btn_pressed"] forState:UIControlStateHighlighted];
        UIBarButtonItem* barButton = [[UIBarButtonItem alloc]
                                      initWithCustomView:menubarButton];
        if(appDelegate.currentLang==Arabic)
            self.navigationItem.rightBarButtonItem = barButton;
        else
            self.navigationItem.leftBarButtonItem = barButton;
        
        [menubarButton addTarget:self action:@selector(onMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [appDelegate canOpenMenu:NO];
    }
    if (withHome) {
        UIButton *homebarButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 15, 36, 36)];
        [homebarButton setImage:[UIImage imageNamed:@"homeBtn"] forState:UIControlStateNormal];
      //  [homebarButton setImage:[UIImage imageNamed:@"home_btn_pressed"] forState:UIControlStateHighlighted];
        UIBarButtonItem* barButtonHome = [[UIBarButtonItem alloc]
                                          initWithCustomView:homebarButton];
        if(appDelegate.currentLang==Arabic)
            self.navigationItem.leftBarButtonItem = barButtonHome;
        else
            self.navigationItem.rightBarButtonItem = barButtonHome;
        
        [homebarButton addTarget:self action:@selector(onHomePressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    self.navigationItem.hidesBackButton = YES;
    navBar.barTintColor=[self getMainColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
}

- (IBAction)goBack:(id)sender   {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onHomePressed:(id)sender{
    HomeViewController *dash=[self.storyboard instantiateViewControllerWithIdentifier:SeagueHomeScreen];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        [self.navigationController pushViewController:dash animated:YES];
    }else{
        for (UIViewController *viewController in self.navigationController.viewControllers) {
            if ([viewController class] == [HomeViewController class]) {
                [self.navigationController popToViewController:viewController animated:NO];
                break;
                
            }
        }
    }
}

- (IBAction)onMenuButtonPressed:(id)sender  {
   // self.viewDeckController.panningCancelsTouchesInView=YES;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   // CustomNavigationController *nav = (CustomNavigationController *)self.navigationController;
    [delegate openCloseMenu];
    
}



#pragma mark - touch methods


//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self onMenuButtonPressed:nil];
}
- (void)initalizeViews {
    
}

-(void)initRefreshControl:(UITableView*)tableView{
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:[UIColor whiteColor]];
    UIColor *color = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1];
    [refreshControl setBackgroundColor:color];
    refreshControl.layer.zPosition = tableView.backgroundView.layer.zPosition + 1;
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refreshControl];

}
#pragma mark - localize lables

-(void)locatizeLables{
}

#pragma mark - layout funtions
-(void)switchLayout{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(delegate.currentLang==Arabic){
        [self switchToRightLayout];
    }else if(delegate.currentLang==English){
        [self switchToLeftLayout];
    }
}

-(void)switchToLeftLayout{
    
}

-(void)switchToRightLayout{
    
}

- (void)refresh:(UIRefreshControl *)refreshControl_ {
}
#pragma mark - refresh data
-(void) refreshView{
    
}

#pragma mark- activity funtions

-(void)showActivityViewer
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIWindow *window = delegate.window;
    activityView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, window.bounds.size.width, window.bounds.size.height)];
    activityView.backgroundColor = [UIColor blackColor];
    activityView.alpha = 0.5;
    
    UIActivityIndicatorView *activityWheel = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(window.bounds.size.width / 2 - 12, window.bounds.size.height / 2 - 12, 24, 24)];
    activityWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityWheel.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                      UIViewAutoresizingFlexibleRightMargin |
                                      UIViewAutoresizingFlexibleTopMargin |
                                      UIViewAutoresizingFlexibleBottomMargin);
    [activityWheel setColor:[UIColor orangeColor]];
    [activityView addSubview:activityWheel];
    [window addSubview: activityView];
    
    [[[activityView subviews] objectAtIndex:0] startAnimating];
}
-(void)hideActivityViewer
{
    [[[activityView subviews] objectAtIndex:0] stopAnimating];
    [activityView removeFromSuperview];
    activityView = nil;
}

#pragma mark - back button color

+ (UIColor*)getBackBtnColor{
    return [UIColor whiteColor];
}

#pragma mark - methods


-(void)logout{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.islogOut=YES;
    hasHome=NO;
   // delegate.DB_data=nil;
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")){
        //[self.navigationController popToRootViewControllerAnimated:NO];
    }else{
        for (UIViewController *viewController in self.navigationController.viewControllers) {
            if ([viewController class] == [LoginViewController class]) {
                [self.navigationController popToViewController:viewController animated:NO];
                break;
                
            }
        }
    }
    [delegate canOpenMenu:NO];
    [StaticFuntions clearProfileData];
    UIViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:SeagueLoginScreen];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(UIColor*)getMainColor{
    return [UIColor colorWithRed:34.0/255.0 green:163.0/255.0 blue:216.0/255.0 alpha:1];
}
@end
