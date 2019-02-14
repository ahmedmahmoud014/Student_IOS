//
//  BooksCollectionViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/12/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookObj.h"

@interface BooksCollectionViewCell : UICollectionViewCell{
    UIImageView *bgImg;
    UILabel *nameLbl;
    UILabel *borrowedDateLbl;
    UILabel *borrowedDateTextLbl;
    BookObj *bObj;
}

@property (nonatomic,retain) IBOutlet UIImageView *bgImg;
@property (nonatomic,retain) IBOutlet UILabel *nameLbl;
@property (nonatomic,retain) IBOutlet UILabel *borrowedDateLbl;
@property (nonatomic,retain) IBOutlet UILabel *borrowedDateTextLbl;


-(void)initWithBookObj:(BookObj *)obj withRowId:(int)rowId;


@end
