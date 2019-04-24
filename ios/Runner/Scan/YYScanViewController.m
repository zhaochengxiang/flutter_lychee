//
//  YYScanViewController.m
//  ZCXLibrary
//
//  Created by zcx on 2018/6/20.
//  Copyright © 2018年 zcx. All rights reserved.
//

#import "YYScanViewController.h"
#import "Config.h"
#import "YYScanBGView.h"
#import <AVFoundation/AVFoundation.h>
#import "YYCrossPlatformService.h"

@interface YYScanViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic,weak) IBOutlet UIView* backView;
@property (nonatomic,weak) IBOutlet UIView* lightView;
@property (nonatomic,weak) IBOutlet UIView* containerView;
@property (nonatomic,weak) IBOutlet YYScanBGView *scanBGView;
@property (nonatomic,weak) IBOutlet UIImageView *scanRectView;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic,strong) UIImageView *scanLine;
@property (nonatomic,weak) IBOutlet UILabel* unknownLabel;

@property (nonatomic,weak) IBOutlet NSLayoutConstraint* topViewHeightConstraint;

@property(nonatomic) BOOL lighting;

@end

@implementation YYScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isDisposeCaptureOutputMetadata = NO;
    self.lighting = NO;
    self.topViewHeightConstraint.constant = isPhoneX?88:64;
    
    [self.backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewClicked)]];
    [self.lightView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lightViewClicked)]];
    [self.containerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(containerViewClicked)]];
    [self configUI];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(applicationDidBecomeActive:)
               name:UIApplicationDidBecomeActiveNotification
             object:nil];
    [nc addObserver:self
           selector:@selector(applicationWillResignActive:)
               name:UIApplicationWillResignActiveNotification
             object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self scanViewWillAppear];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self stopScan];
    
}

- (BOOL)shouldNavigationBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)backViewClicked {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)lightViewClicked {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        
        _lighting = !_lighting;
        
        [device lockForConfiguration:nil];
        if (_lighting) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

- (void)containerViewClicked {
    
}

- (void)hideUnKnownTip {
    self.unknownLabel.hidden = YES;
}

- (void)disposeUnknownISBN {
    self.unknownLabel.hidden = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideUnKnownTip) object:nil];
    [self performSelector:@selector(hideUnKnownTip) withObject:nil afterDelay:5.0];
}

- (void)scanViewWillAppear {
    [self startScan];
}

- (CGFloat)scanRectViewWidth {
    return 208;
}

- (CGRect)scanRect {
    CGFloat scanRectViewWidth = [self scanRectViewWidth];

    return CGRectMake((SCREEN_WIDTH-scanRectViewWidth)/2, 100, scanRectViewWidth, scanRectViewWidth);
}

- (CGRect)scanBGRect {
    return CGRectMake(0, 0, SCREEN_WIDTH,  isPhoneX?(SCREEN_HEIGHT-88.0):(SCREEN_HEIGHT-64.0));
}

- (NSArray*)metadataObjectTypes {
    return @[
             AVMetadataObjectTypeEAN13Code,
             AVMetadataObjectTypeEAN8Code,
             AVMetadataObjectTypeCode128Code,
             AVMetadataObjectTypeQRCode
             ];
}

- (void)configUI {
    CGFloat scanRectViewWidth = [self scanRectViewWidth];
    
    CGRect scanRect = [self scanRect];
    CGRect scanBGRect = [self scanBGRect];
    
    if (!_previewLayer) {
        NSError *error;
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
        if (!input) {
            
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"相机服务未开启" message:@"请在系统设置中开启相机服务" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction* settingAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL*url=[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:settingAction];
            
            [self.navigationController presentViewController:alertController animated:YES completion:nil];
            return;
            
        }else{
            //设置会话的输入设备
            AVCaptureSession *captureSession = [AVCaptureSession new];
            if ([captureSession canAddInput:input]) {
                [captureSession addInput:input];
            }
            //对应输出
            AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
            [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
         
            if ([captureSession canAddOutput:captureMetadataOutput]) {
                [captureSession addOutput:captureMetadataOutput];
            }
            
            //支持扫描二维码和条形码 必须放在addOutput之后
            captureMetadataOutput.metadataObjectTypes = [self metadataObjectTypes];
            
            captureMetadataOutput.rectOfInterest = CGRectMake(
                                                              CGRectGetMinY(scanRect)/CGRectGetHeight(scanBGRect),
                                                              1 - CGRectGetMaxX(scanRect)/CGRectGetWidth(scanBGRect),
                                                              CGRectGetHeight(scanRect)/CGRectGetHeight(scanBGRect),
                                                              CGRectGetWidth(scanRect)/CGRectGetWidth(scanBGRect));
            //将捕获的数据流展现出来
            _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
            [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            [_previewLayer setFrame:scanBGRect];
        }
    }
    
    _scanBGView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    _scanBGView.scanRect = scanRect;
    
    _scanRectView.image = [[UIImage imageNamed:@"scan_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 25, 25)];
    _scanRectView.clipsToBounds = YES;
    
    //扫描线
    UIImage *lineImage = [UIImage imageNamed:@"scan_line"];
    _scanLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, scanRectViewWidth, 2)];
    _scanLine.contentMode = UIViewContentModeScaleToFill;
    _scanLine.image = lineImage;
    
    [self.containerView.layer insertSublayer:self.previewLayer atIndex:0];
    
    [self.scanRectView addSubview:_scanLine];
    [self startScan];
}

- (void)scanLineStartAction{
    [self scanLineStopAction];
    
    CABasicAnimation *scanAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    scanAnimation.fromValue = @(_scanLine.frame.origin.y + _scanLine.frame.size.height);
    scanAnimation.toValue = @(self.scanRectViewWidth - _scanLine.frame.origin.y - _scanLine.frame.size.height);
    
    scanAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    scanAnimation.repeatCount = CGFLOAT_MAX;
    scanAnimation.duration = 2.0;
    scanAnimation.autoreverses = YES;
    
    [_scanLine.layer addAnimation:scanAnimation forKey:@"basic"];
}

- (void)scanLineStopAction{
    [_scanLine.layer removeAllAnimations];
}

- (BOOL)validISBN:(NSString*_Nullable)isbn {
    if (!isbn) return NO;
    
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:isbn] && ((isbn.length==13&&([isbn hasPrefix:@"978"]||[isbn hasPrefix:@"979"])) || isbn.length==10)) {
        return YES;
    }
    
    return NO;
    
}

#pragma mark public
- (BOOL)isScaning{
    return _previewLayer.session.isRunning;
}

- (void)startScan{
    [_previewLayer.session startRunning];
    [self scanLineStartAction];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (_lighting) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

- (void)stopScan{
    [_previewLayer.session stopRunning];
    [self scanLineStopAction];
}

- (void)disposeCaptureOutputMetadata {
    
    [YYCrossPlatformService.service emitEvent:@"native_event_scan_code" params:@{@"code":_scanCode}];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark Notification
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self startScan];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self stopScan];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if ([self isScaning] && metadataObjects.count > 0 && !self.isDisposeCaptureOutputMetadata) {
        AVMetadataMachineReadableCodeObject *metadata = metadataObjects[0];
        _scanCode = [[(AVMetadataMachineReadableCodeObject *)metadata stringValue] copy];
        
        self.isDisposeCaptureOutputMetadata = YES;
        [self disposeCaptureOutputMetadata];
    }
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

@end
