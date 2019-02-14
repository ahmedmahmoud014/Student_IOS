//
//  MenuCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 6/24/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
@synthesize menuImgView;
@synthesize menuNameLbl;
@synthesize NotifSwitch;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if(selected){
        //menuImgView.image=menuObj.selectedMenuImg;
        menuImgView.image=menuObj.menuImg;
        self.contentView.backgroundColor=[UIColor colorWithRed:31.0/255.0 green:152.0/255.0 blue:203.0/255.0 alpha:1];
        
    }else{
        menuImgView.image=menuObj.menuImg;
        self.contentView.backgroundColor=[UIColor whiteColor];
    }
}

#pragma mark - funtions

-(void) initWithName:(NSString *)Name withImage:(UIImage *)img isSwitch:(BOOL)isSwitch{
    menuNameLbl.text=Name;
    menuImgView.image=img;
    NotifSwitch.hidden=!isSwitch;
    /* if(isSwitch){
     BOOL value=[[DatabaseManager sharedInstance] showNotifications];
     NotifSwitch.on= value;
     }*/
}

-(void)initWithMenu:(MenuObj *)menu{
    menuObj=menu;
    [self initWithName:menu.menuName withImage:menu.menuImg isSwitch:menu.isNotifSwitch];
}

#pragma mark - events

-(IBAction)onSwitchChanged:(id)sender{
    /*BOOL value=[[DatabaseManager sharedInstance] showNotifications];
     //[[DatabaseManager sharedInstance] setShowNotification:! value];
     [[DatabaseManager sharedInstance] setShowNotifications:! value];
     [[DatabaseManager sharedInstance] saveMyContext];
     
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     [appDelegate updateDeviceToken];*/
}
@end
