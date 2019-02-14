//
//  CustomNavigationController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 6/23/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController

- (void)setPanning:(BOOL)allow;
-(UIViewController*)getTopView;

@end
