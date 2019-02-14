//
//  BooksCollectionViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/12/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BooksCollectionViewCell.h"

#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"

@implementation BooksCollectionViewCell

@synthesize bgImg,nameLbl,borrowedDateLbl,borrowedDateTextLbl;

-(void)initWithBookObj:(BookObj *)obj withRowId:(int)rowId{
    bObj=obj;
    int mod= rowId%5;
    switch (mod) {
        case bookBlue:
            bgImg.image=[UIImage imageNamed:@"blue_b.png"];
            break;
        case bookPurple:
            bgImg.image=[UIImage imageNamed:@"purple_b.png"];
            break;
        case bookOrange:
            bgImg.image=[UIImage imageNamed:@"yellow_b.png"];
            break;
        case bookGreen:
            bgImg.image=[UIImage imageNamed:@"green_b.png"];
            break;
        case bookRed:
            bgImg.image=[UIImage imageNamed:@"red_b.png"];
            break;
        default:
            break;
    }
    
    nameLbl.text=bObj.bookName;
    if([StaticFuntions isStringEmpty:bObj.borrowedDate])
        borrowedDateLbl.text=@"--/--/--";
    else
        borrowedDateLbl.text=bObj.borrowedDate;
    borrowedDateTextLbl.text=bookBorrowedDateTitle;
    
    [self changeAlignment];
    
}

-(void)changeAlignment{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTextAlignment align;
    if(appDelegate.currentLang==English){
        align=NSTextAlignmentLeft;
    }else{
        align=NSTextAlignmentRight;
    }
    
    nameLbl.textAlignment=align;
    //borrowedDateTextLbl.textAlignment=align;
   // borrowedDateLbl.textAlignment=align;
}

@end
