//
//  BooksViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/12/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BooksViewController.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "AppDelegate.h"
#import "BooksCollectionViewCell.h"
#import "RequestManager.h"

@interface BooksViewController ()

@end

@implementation BooksViewController
@synthesize collectionView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
  /*
    if(IS_IPAD){
        //NSLog(@"4");
        int x= (self.view.frame.size.width- collectionView.frame.size.width)/2;
        collectionView.frame=CGRectMake(x, collectionView.frame.origin.y, collectionView.frame.size.width, collectionView.frame.size.height);
        noDataLbl.frame=CGRectMake(x, noDataLbl.frame.origin.y, noDataLbl.frame.size.width, noDataLbl.frame.size.height);
        noDataImg.frame=CGRectMake(x+110, noDataImg.frame.origin.y, noDataImg.frame.size.width, noDataImg.frame.size.height);
    }*/

    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:[UIColor whiteColor]];
    UIColor *color = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1];
    [refreshControl setBackgroundColor:color];
   // refreshControl.layer.zPosition = collectionView.backgroundView.layer.zPosition + 1;
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [collectionView addSubview:refreshControl];
    self.collectionView.alwaysBounceVertical = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - base methods

-(void)initalizeViews{

    //[self connect];
    
     [self refresh:nil];
}

-(void)locatizeLables{
    self.navigationItem.title=bookScreenTitle;
    noDataLbl.text=bookBorrowedNoDataMSG;
}

-(void)switchToLeftLayout{
    
}

-(void)switchToRightLayout{
        
}

#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if([dataArray count]==0){
        noDataLbl.hidden=NO;
        //noDataImg.hidden=NO;
        return 0;
    }
    noDataLbl.hidden=YES;
  //  noDataImg.hidden=YES;
    return [dataArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSMutableArray *sectionArray = [dataArray objectAtIndex:section];
    return [sectionArray count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView_ cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"BooksCollectionViewCell";
    
    BooksCollectionViewCell *cell = (BooksCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSMutableArray *data = [dataArray objectAtIndex:(int)indexPath.section];
    BookObj *book = (BookObj*)[data objectAtIndex:(int)indexPath.row];
    [cell initWithBookObj:book withRowId:(int)indexPath.row];
    
    return cell;
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - methods

-(void)connect{
    [refreshControl endRefreshing];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] getStudentBorrowedBooks:self withStudentId:appDelegate.studentObj.studentId];
    [self showActivityViewer];
}


#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    if(data!=nil){
        booksArr=(NSMutableArray*)data;
        if(booksArr!=nil&& [booksArr count]!=0)
            dataArray=[[NSArray alloc] initWithObjects:booksArr, nil];
    }else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
    [collectionView reloadData];
}

#pragma mark - refresh

- (void)refresh:(UIRefreshControl *)refreshControl_ {
    noDataLbl.hidden=YES;
    [self connect];
}
@end
