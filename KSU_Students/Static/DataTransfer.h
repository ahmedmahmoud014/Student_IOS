//
//  DataTransfer.h
//  KSU_Students
//
//  Created by EJ-Mac book on 6/7/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CustomError.h"
#import "StaticVariables.h"

@protocol DataTransferDelegate <NSObject>
@required
- (void) processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service;
@end
// Protocol Definition ends here

@interface DataTransfer : NSObject

{
    id <DataTransferDelegate> _delegate;
    
}
@property (nonatomic,strong) id delegate;

- (void)dataLoaded:(id)data error:(CustomError *)error withService:(Service) service;

@end
