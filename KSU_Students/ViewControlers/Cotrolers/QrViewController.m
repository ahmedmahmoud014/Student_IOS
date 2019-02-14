//
//  QRViewController.m
//  KSU_Students
//
//  Created by EJ-Mac book on 8/2/15.
//  Copyright (c) 2015 E-Jawdah. All rights reserved.
//

#import "QrViewController.h"
#import "AppDelegate.h"
#import "LocalizedMessages.h"
#import "StaticFuntions.h"
#import "ScheduleTableViewCell.h"
#import "RequestManager.h"

@interface QrViewController ()


@end

@implementation QrViewController

@synthesize qrPreview;
@synthesize lblStatus;
@synthesize sendBtn;
@synthesize reTakeBtn;
@synthesize captureSession;
@synthesize videoPreviewLayer;
@synthesize audioPlayer;
@synthesize isReading;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeNavigationBar:YES WithMenu:YES];
    // Set the initial value of the flag to NO.
    isReading = NO;
    // Begin loading the sound effect so to have it ready for playback when it's needed.
    [self loadBeepSound];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - base methods

-(void)initalizeViews{

}

-(void)locatizeLables{
    self.navigationItem.title=AttendanceTitleText;
   
    noDataLbl.text=NoDataFoundMsg;
    
    [sendBtn setTitle:SendButtonText forState:UIControlStateNormal];
    [reTakeBtn setTitle:RetakeButtonText forState:UIControlStateNormal];
    [_retryButton setTitle:RetryButtonText forState:UIControlStateNormal];
    
    [NSTimer scheduledTimerWithTimeInterval:0.000000000000000000000001f target:self selector:@selector(loadQRReader) userInfo:nil repeats:FALSE];
}

-(void)switchToLeftLayout{
    
}

-(void)switchToRightLayout{
}

#pragma mark - methods

-(void)loadQRReader{

    // Initially make the captureSession object nil.
    captureSession = nil;
    
    if (!isReading)
    {
        lblStatus.text = @"";
        lblStatus.hidden = YES;
        [self startReading];
        
    }
    
    // Set to the flag the exact opposite value of the one that currently has.
    isReading = YES;
}

-(void)connect{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //-(void)SendQRCode:(id)delegate withStudentNum:(NSString*)withStudentNum withCode:(NSString*)withCode
    [[RequestManager sharedInstance] SendQRCode:self withStudentNum:appDelegate.studentObj.studentId withCode:lblStatus.text];
    [self showActivityViewer];
}


- (BOOL)startReading {
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [captureSession addInput:input];
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
    [videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //[videoPreviewLayer setFrame:qrPreview.frame];
    

    videoPreviewLayer.frame = qrPreview.layer.bounds;
    [qrPreview.layer addSublayer:videoPreviewLayer];
    // Start video capture.
    [captureSession startRunning];
    
    return YES;
}


-(void)stopReading{
    // Stop video capture and make the capture session object nil.
    [captureSession stopRunning];
    captureSession = nil;
    
    videoPreviewLayer.hidden = YES;
    lblStatus.hidden = FALSE;
    _retryButton.hidden = true;
}


-(void)loadBeepSound{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If the audio player was successfully initialized then load it in memory.
        [audioPlayer prepareToPlay];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread.
            
            
            // Don't write QR code value to lblStatus
//            [lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            
//            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
            [self performSelectorOnMainThread:@selector(connectWithQRCode:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            
            // If the audio player is not nil, then play the sound effect.
            if (audioPlayer) {
                [audioPlayer play];
            }
        }
    }
    
    
}

- (void)connectWithQRCode:(NSString *)qrCode {
    [self stopReading];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[RequestManager sharedInstance] SendQRCode:self withStudentNum:appDelegate.studentObj.studentId withCode:qrCode];
    [self showActivityViewer];
}

#pragma mark - connection

- (void)processCompleted:(id)data error:(CustomError *)error withService:(NSNumber *)service{
    [self hideActivityViewer];
    _retryButton.hidden = false;
    if(data!=nil) {
        NSString *previewedMessage = @"";
        if ([data isEqualToString:@"300"]) {
            previewedMessage = QRInvalidMsg;
            _statusImageView.image = [UIImage imageNamed:@"invalid"];
        }else if ([data isEqualToString:@"301"]) {
            previewedMessage = QRExpiredMsg;
            _statusImageView.image = [UIImage imageNamed:@"expired"];
        }else if ([data isEqualToString:@"302"]) {
            previewedMessage = QRAddedMsg;
            _statusImageView.image = [UIImage imageNamed:@"added"];
        }else if ([data isEqualToString:@"0"]) {
            previewedMessage = QRSuccessMsg;
            _statusImageView.image = [UIImage imageNamed:@"success"];
            _retryButton.hidden = true;
        }
        lblStatus.text = previewedMessage;
        lblStatus.hidden = false;
        _statusImageView.hidden = false;
//        [StaticFuntions showAlertWithTitle:ApplicationTitleText Message:previewedMessage];
    }else{
        lblStatus.text = error.errorMessage;
        lblStatus.hidden = false;
        _statusImageView.image = [UIImage imageNamed:@"invalid"];
        _statusImageView.hidden = false;
//        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:error.errorMessage];
    }
}

#pragma mark - events

-(IBAction)onPressTakeCapture:(id)sender{
    isReading = NO;
    [self stopReading];
    [self loadQRReader];
}
-(IBAction)onPressSendQR:(id)sender{
    if (![StaticFuntions isStringEmpty:lblStatus.text]) {
        [self connect];
    }
    else{
        [StaticFuntions showAlertWithTitle:ErrorGeneralTitle Message:QRLoadingMsg];
    }
    
}

@end
