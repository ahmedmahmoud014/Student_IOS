//
//  CalendarTableViewCell.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/13/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "CalendarTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "LocalizedMessages.h"
#import "StaticFuntions.h"

@implementation CalendarTableViewCell
@synthesize eventLbl;
@synthesize fromLbl;
@synthesize fromTextLbl;
@synthesize toLbl;
@synthesize toTextLbl;

@synthesize circle;
@synthesize circlesSepalator;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - methods

-(void)initWithCalendarObj:(CalendarObj*)obj withRowIndex:(int)row{
    self.circle.layer.cornerRadius = 10;
    
    eventLbl.text= obj.event;
    fromLbl.text=obj.hijriDate;
    toLbl.text=obj.georgDate;
    
    fromTextLbl.text=DateFromText;
    toTextLbl.text=DateToText;
    
    NSMutableArray * arr=[self getColors];
    int mod=row%((int)[arr count]);
    self.circle.backgroundColor=(UIColor*)[arr objectAtIndex:mod];
}

- (NSMutableArray*)getColors{
    NSMutableArray * arr=[[NSMutableArray alloc] init];
    [arr addObject:[UIColor colorWithRed:216.0/255.0 green:65.0/255.0 blue:72.0/255.0 alpha:1]];
    [arr addObject:[UIColor colorWithRed:160.0/255.0 green:70.0/255.0 blue:136.0/255.0 alpha:1]];
    [arr addObject:[UIColor colorWithRed:244.0/255.0 green:151.0/255.0 blue:42.0/255.0 alpha:1]];
    [arr addObject:[UIColor colorWithRed:61.0/255.0 green:169.0/255.0 blue:154.0/255.0 alpha:1]];
    [arr addObject:[UIColor colorWithRed:0/255.0 green:142.0/255.0 blue:197.0/255.0 alpha:1]];
    
    return arr;
}

@end

