//
//  MenuObj.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/11/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "MenuObj.h"
#import "StaticVariables.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import "BaseViewController.h"
#import "LocalizedMessages.h"

@implementation MenuObj

@synthesize menuImg;
@synthesize menuName;
@synthesize isNotifSwitch;

#pragma mark - get menu objects

+(MenuObj*)getHomeMenu{
    MenuObj *cell=[[MenuObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"home.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuHomeText;
    return cell;
}

+(MenuObj*)getChangePWMenu{
    MenuObj *cell=[[MenuObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"change_pw.png"];
    //cell.selectedMenuImg=[UIImage imageNamed:@"select_new_location_menu_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuChangePWText;
    return cell;
}

+(MenuObj*)getLanguageMenu{
    MenuObj *cell=[[MenuObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"language.png"];
    //cell.selectedMenuImg=[UIImage imageNamed:@"language_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuLangText;
    return cell;
}

+(MenuObj*)getLogOutMenu{
    MenuObj *cell=[[MenuObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"logout.png"];
    //  cell.selectedMenuImg=[UIImage imageNamed:@"locate_driver_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuSignoutText;
    return cell;
}


+(MenuObj*)getAboutMenu{
    MenuObj *cell=[[MenuObj alloc] init];
    cell.menuImg=[UIImage imageNamed:@"about.png"];
    //   cell.selectedMenuImg=[UIImage imageNamed:@"about_swaweeg_s.png"];
    cell.isNotifSwitch=NO;
    cell.menuName=MenuAboutText;
    return cell;
}


+(MenuObj*)getMenuForindex:(int)index{
    
    switch (index) {
        case HomeMenu:
            return  [self getHomeMenu];
            break;
        case ChangePWMenu:
            return  [self getChangePWMenu];
            break;
       /* case LanguageMenu:
            return  [self getLanguageMenu];
            break;
        */case AboutMenu:
            return  [self getAboutMenu];
            break;
        case SignoutMenu:
            return  [self getLogOutMenu];
            break;
        default:
            break;
    }
    
    return nil;
}

+(NSString*)getSeagueName:(int)index{
    switch (index) {
        case HomeMenu:
            return  SeagueHomeScreen;
            break;
        case ChangePWMenu:
            return  SeagueChangePWScreen;
            break;
        /*case LanguageMenu:
           // [self logout_method];
            break;*/
        case SignoutMenu:
            [self logout_method];
            break;
        case AboutMenu:
            return  SeagueAboutScreen;
            break;
        default:
            break;
    }
    
    return @"";
}

+(void)logout_method{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CustomNavigationController *nav=(CustomNavigationController*)appDelegate.centerController;
    //[((BaseViewController*)[nav getTopView]) hideMenuViewer];
    [((BaseViewController*)[nav getTopView]) onMenuButtonPressed:nil];
    [((BaseViewController*)[nav getTopView]) logout];
    
}


@end
