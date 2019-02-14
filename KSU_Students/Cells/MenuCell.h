//
//  MenuCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 6/24/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuObj.h"

@interface MenuCell : UITableViewCell{

    MenuObj* menuObj;
}

@property (nonatomic,retain) IBOutlet UILabel* menuNameLbl;
@property (nonatomic,retain) IBOutlet UIImageView* menuImgView;
@property (nonatomic,retain) IBOutlet UISwitch *NotifSwitch;

-(void) initWithMenu:(MenuObj*)menu;
-(void) initWithName:(NSString *)Name withImage:(UIImage *)img isSwitch:(BOOL)isSwitch;
-(IBAction)onSwitchChanged:(id)sender;


@end
