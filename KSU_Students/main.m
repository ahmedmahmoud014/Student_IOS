//
//  main.m
//  KSU_Students
//
//  Created by EJ-Mac book on 6/4/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSBundle+Language.h"

int main(int argc, char * argv[]) {

    

    [NSBundle setLanguage:@"ar"];
    
    
    @autoreleasepool {
                return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
