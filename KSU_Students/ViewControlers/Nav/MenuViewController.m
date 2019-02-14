//
//  MenuViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 6/23/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "MenuViewController.h"

#import "AppDelegate.h"
#import "MenuObj.h"
#import "MenuCell.h"
#import "LocalizedMessages.h"
#import "CustomNavigationController.h"
#import "BaseViewController.h"

#import <QuartzCore/QuartzCore.h>


@implementation MenuViewController
@synthesize menuTitleLbl,imageView;

- (id)initWithCoder:(NSCoder *)aDecoder     {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

#pragma mark - table delegate

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier=@"MenuCell";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==English)
        CellIdentifier=@"MenuCell_en";
    else
        CellIdentifier=@"MenuCell";
    
    MenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MenuCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    [cell initWithMenu:[MenuObj getMenuForindex:(int)indexPath.row]];
    
    return cell;
    //return nil;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return NumberMenuItems;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    NSString * seagueName =[MenuObj getSeagueName:(int)indexPath.row];
    
    if([seagueName isEqualToString:@""]){
        
    }else {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        CustomNavigationController *navigationController = (CustomNavigationController *)appDelegate.centerController;
        
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:seagueName];
        if([[navigationController getTopView] class]!=[viewController class]){
            [navigationController pushViewController:viewController animated:YES];
        }

        [((BaseViewController*)[navigationController getTopView]) onMenuButtonPressed:nil];
    }
}

#pragma mark - view

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeLocalization];
    
}
-(void) viewDidLoad{
    [super viewDidLoad];
    self.tableView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.tableView.layer.borderWidth=0.5f;
}



#pragma mark - methods

-(void)changeLocalization{
    menuTitleLbl.text=MenuTitleText;
   /* AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(appDelegate.currentLang==Arabic){
        CGRect frame=menuTitleLbl.frame;
        if(IS_IPAD){
            frame.origin.x=MenuStartXIPad;
            
        }else
            frame.origin.x=MenuStartX;
        menuTitleLbl.frame=frame;
        
        frame=imageView.frame;
        if(IS_IPAD)
            frame.origin.x=MenuStartXIPad;
        else
            frame.origin.x=MenuStartX;
        imageView.frame=frame;
    }else{
        CGRect frame=menuTitleLbl.frame;
        frame.origin.x=0;
        menuTitleLbl.frame=frame;
        
        frame=imageView.frame;
        frame.origin.x=0;
        imageView.frame=frame;
    }*/
    [self.tableView reloadData];
}
@end
