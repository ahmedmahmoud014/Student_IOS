//
//  TransactionsObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/27/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionsObj : NSObject{
    NSString * details;
    NSString * className;
    NSString * status;
}

@property (nonatomic,retain) NSString * details;
@property (nonatomic,retain) NSString * className;
@property (nonatomic,retain) NSString * status;
@end
