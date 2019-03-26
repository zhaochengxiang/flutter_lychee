//
//  UIViewControllerDemo.m
//  Runner
//
//  Created by Jidong Chen on 2018/10/17.
//  Copyright © 2018年 The Chromium Authors. All rights reserved.
//

#import "UIViewControllerDemo.h"
#import <Flutter/Flutter.h>
#import "YYRouter.h"
#import "YYCrossPlatformService.h"

@interface UIViewControllerDemo () <FlutterServiceEventListner>

@end

@implementation UIViewControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [YYCrossPlatformService.service addListener:self forEvent:@"flutter test"];
}

- (void)onEvent:(NSString *)event params:(NSString *)params {
    NSLog(@"params:%@",params);
}

- (IBAction)pushFlutterPage:(id)sender {
    [YYCrossPlatformService MessageToFlutter:^(NSDictionary *r){
        NSLog(@"Message to Flutter success!");
    } message:@"Message from native"];
    
    [YYCrossPlatformService.service emitEvent:@"test" params:@{@"param":@"name"}];
    
    [YYRouter.sharedRouter openPage:@"flutter://login" params:@{} animated:YES completion:^(BOOL f){}];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
