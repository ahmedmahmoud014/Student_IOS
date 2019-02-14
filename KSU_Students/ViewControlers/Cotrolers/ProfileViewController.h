//
//  ProfileViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 7/22/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import "ProfileObj.h"

@interface ProfileViewController : BaseViewController<DataTransferDelegate>{
    ProfileObj* pObj;
}

@property(nonatomic,retain)IBOutlet UIImageView * profileImg;
@property(nonatomic,retain)IBOutlet UILabel * nameLbl;
@property(nonatomic,retain)IBOutlet UILabel * studentIdLbl;
@property(nonatomic,retain)IBOutlet UILabel * studentIdValLbl;
@property(nonatomic,retain)IBOutlet UILabel * telNoLbl;
@property(nonatomic,retain)IBOutlet UILabel * telNoValLbl;
@property(nonatomic,retain)IBOutlet UILabel * facultyLbl;
@property(nonatomic,retain)IBOutlet UILabel * facultyValLbl;
@property(nonatomic,retain)IBOutlet UILabel * specializeLbl;
@property(nonatomic,retain)IBOutlet UILabel * specializeValLbl;
@property(nonatomic,retain)IBOutlet UILabel * statusLbl;
@property(nonatomic,retain)IBOutlet UILabel * statusValLbl;
@property(nonatomic,retain)IBOutlet UILabel * emailLbl;
@property(nonatomic,retain)IBOutlet UILabel * emailValLbl;
@property(nonatomic,retain)IBOutlet UILabel * nationalIdLbl;
@property(nonatomic,retain)IBOutlet UILabel * nationalIdValLbl;
@property(nonatomic,retain)IBOutlet UILabel * nationalityLbl;
@property(nonatomic,retain)IBOutlet UILabel * nationalityValLbl;
@property(nonatomic,retain)IBOutlet UILabel * degreeLbl;
@property(nonatomic,retain)IBOutlet UILabel * degreeValLbl;


@end
