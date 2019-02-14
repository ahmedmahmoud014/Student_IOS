//
//  BooksViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/12/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"

@interface BooksViewController : BaseViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DataTransferDelegate>
{
    UICollectionView *collectionView;
    NSMutableArray *booksArr;

    NSArray *dataArray;
    //UIImageView * noDataImg;
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

//@property (nonatomic, strong) IBOutlet UIImageView * noDataImg;



@end
