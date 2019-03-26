#include "AppDelegate.h"
#include "YYRouter.h"

@interface AppDelegate () <UIGestureRecognizerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    FLBFlutterViewContainer *fvc = FLBFlutterViewContainer.new;
    [fvc setName:@"flutter://home" params:@{}];
    
    UINavigationController *rvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    rvc.navigationBarHidden = YES;
    rvc.interactivePopGestureRecognizer.delegate = self;
    rvc.interactivePopGestureRecognizer.enabled  = YES;
    
    YYRouter *router = [YYRouter sharedRouter];
    router.navigationController = rvc;
    
    [FlutterBoostPlugin.sharedInstance startFlutterWithPlatform:router
                                                        onStart:^(FlutterViewController *fvc) {
                                                            
                                                        }];
    
    
    self.window.rootViewController = rvc;
    return YES;
}

@end
