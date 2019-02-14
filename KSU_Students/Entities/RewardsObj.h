//
//  RewardsObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/27/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RewardsObj : NSObject{
    NSString * amount;
    NSString * details;
    NSString * date;
}

@property(nonatomic,retain) NSString * amount;
@property(nonatomic,retain) NSString * details;
@property(nonatomic,retain) NSString * date;


@end
