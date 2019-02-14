//
//  MenuViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 6/23/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController  : UITableViewController <UITableViewDataSource,UITableViewDelegate>{
    
    UILabel *menuTitleLbl;
    UIImageView *imageView;
}

@property(nonatomic,retain) IBOutlet UILabel *menuTitleLbl;
@property(nonatomic,retain) IBOutlet UIImageView *imageView;

@end
