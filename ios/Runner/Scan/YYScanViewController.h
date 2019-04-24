//
//  YYScanViewController.h
//  ZCXLibrary
//
//  Created by zcx on 2018/6/20.
//  Copyright © 2018年 zcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYScanViewControllerDelegate <NSObject>

- (void)scanViewControllerDidFinishedWithData:(id)data;

@end

@interface YYScanViewController : UIViewController

@property (nonatomic,weak) id<YYScanViewControllerDelegate> delegate;
@property (nonatomic,copy) NSString* scanCode;
@property BOOL isDisposeCaptureOutputMetadata;

- (BOOL)isScaning;
- (void)startScan;
- (void)stopScan;
- (void)disposeUnknownISBN;

@end
