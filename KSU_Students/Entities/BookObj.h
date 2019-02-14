//
//  BookObj.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/12/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM( NSUInteger, BookColor ){
    bookBlue=0,
    bookPurple,
    bookOrange,
    bookGreen,
    bookRed
    
};

@interface BookObj : NSObject{
    NSString * bookName;
    NSString *borrowedDate;
    
}

@property(nonatomic,retain) NSString * bookName;
@property(nonatomic,retain) NSString *borrowedDate;
@end
