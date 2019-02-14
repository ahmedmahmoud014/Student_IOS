//
//  MenuObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/11/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM( NSUInteger, myMenu ){
    HomeMenu=0,
    ChangePWMenu,
  //  LanguageMenu,
    AboutMenu,
    SignoutMenu
    
};

@interface MenuObj : NSObject{
    
}


@property (nonatomic,retain) NSString* menuName;
@property (nonatomic,retain) UIImage * menuImg;
@property (nonatomic) BOOL isNotifSwitch;


+(MenuObj*)getHomeMenu;
+(MenuObj*)getChangePWMenu;
+(MenuObj*)getLogOutMenu;
+(MenuObj*)getAboutMenu;
+(MenuObj*)getLanguageMenu;

+(MenuObj*)getMenuForindex:(int)index;

+(NSString*)getSeagueName:(int)index;




@end
