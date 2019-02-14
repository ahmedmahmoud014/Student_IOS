//
//  ScheduleTableViewCell.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleObj.h"

@interface ScheduleTableViewCell : UITableViewCell{
    ScheduleObj * sObj;
    
}


@property (nonatomic,retain) IBOutlet UILabel * classBuildingIdLbl;
@property (nonatomic,retain) IBOutlet UILabel * classPartitionLbl;
@property (nonatomic,retain) IBOutlet UILabel * classFloorLbl;
@property (nonatomic,retain) IBOutlet UILabel * classRoomLbl;
@property (nonatomic,retain) IBOutlet UILabel * classInstractorLbl;
@property (nonatomic,retain) IBOutlet UILabel * courseNoLbl;
@property (nonatomic,retain) IBOutlet UILabel * startTimeLbl;
@property (nonatomic,retain) IBOutlet UILabel * endTimeLbl;
@property (nonatomic,retain) IBOutlet UILabel * sectionLbl;

@property (nonatomic,retain) IBOutlet UILabel * classBuildingIdValLbl;
@property (nonatomic,retain) IBOutlet UILabel * classPartitionValLbl;
@property (nonatomic,retain) IBOutlet UILabel * classFloorValLbl;
@property (nonatomic,retain) IBOutlet UILabel * classRoomValLbl;
@property (nonatomic,retain) IBOutlet UILabel * classInstractorValLbl;
@property (nonatomic,retain) IBOutlet UILabel * courseNoValLbl;
@property (nonatomic,retain) IBOutlet UILabel * startTimeValLbl;
@property (nonatomic,retain) IBOutlet UILabel * endTimeValLbl;
@property (nonatomic,retain) IBOutlet UILabel * sectionValLbl;



-(void)initWithScheduleObj:(ScheduleObj*)obj withRowId:(int)rowId;
@end
