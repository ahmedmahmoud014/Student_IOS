//
//  LoansObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/30/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoansObj : NSObject{
    NSString *type;
    NSString *amount;
    NSString *classYear;
}

@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSString *amount;
@property (nonatomic,retain) NSString *classYear;

@end
