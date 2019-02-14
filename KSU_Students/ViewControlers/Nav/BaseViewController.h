//
//  BaseViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 6/28/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>{

    //unused
    UIView *activityView;
    UIView *MenuView;
    UIImageView * _BGImage;
//////
    UILabel *noDataLbl;
    
    UIRefreshControl* refreshControl;
    BOOL hasHome;

}

@property (nonatomic, retain) IBOutlet UIImageView * BGImage;
@property (nonatomic, retain) IBOutlet UILabel *noDataLbl;

- (IBAction)onMenuButtonPressed:(id)sender;
- (void)customizeNavigationBar:(BOOL)withHome WithMenu:(BOOL)withMenu ;
- (void)initalizeViews;

-(void)showActivityViewer;
-(void)hideActivityViewer;
-(void)switchToRightLayout;
-(void)switchToLeftLayout;
-(void)locatizeLables;

- (IBAction)goBack:(id)sender ;
-(IBAction)onHomePressed:(id)sender;

-(void) refreshView;
-(void)logout;

-(UIColor*)getMainColor;

- (void)refresh:(UIRefreshControl *)refreshControl_;
-(void)initRefreshControl:(UITableView*)tableView;

@end
