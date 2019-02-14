//
//  DataTransfer.m
//  KSU_Students
//
//  Created by EJ-Mac book on 6/7/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "DataTransfer.h"

@implementation DataTransfer

- (void)dataLoaded:(id)data error:(CustomError *)error withService:(Service)service{
    
  //  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //    objc_msgSend(self.delegate, @selector(processCompleted:error:withService:), data, error, [NSNumber numberWithInt:service]);
    
    //   [self.delegate performSelector:@selector(processCompleted:error:withService:) withObject:data    withObject:error withObject:[NSNumber numberWithInt:service]];
    [self.delegate processCompleted:data error:error withService:[NSNumber numberWithInt:service]];
}
@end
