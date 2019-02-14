//
//  QRViewController.h
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransfer.h"
#import <AVFoundation/AVFoundation.h>

@interface QrViewController :  BaseViewController<AVCaptureMetadataOutputObjectsDelegate,DataTransferDelegate> {
    
    UIView *qrPreview;
    UILabel *lblStatus;
    UIButton *sendBtn;
    UIButton *reTakeBtn;
    AVCaptureSession *captureSession;
    AVCaptureVideoPreviewLayer *videoPreviewLayer;
    AVAudioPlayer *audioPlayer;
    BOOL isReading;
}

@property(nonatomic,retain) IBOutlet UIView *qrPreview;
@property(nonatomic,retain) IBOutlet UILabel *lblStatus;
@property(nonatomic,retain) IBOutlet UIButton *sendBtn;
@property(nonatomic,retain) IBOutlet UIButton *reTakeBtn;
@property(nonatomic, strong) AVCaptureSession *captureSession;
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property(nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UIButton *retryButton;
@property(nonatomic) BOOL isReading;

-(BOOL)startReading;
-(void)stopReading;
-(void)loadBeepSound;

-(IBAction)onPressTakeCapture:(id)sender;
-(IBAction)onPressSendQR:(id)sender;

@end
