#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "YYCrossPlatformService.h"
#import "YYScanViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    [[YYCrossPlatformService service] addListener:self forEvent:@"flutter_event_open_scan"];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)onEvent:(NSString *)event params:(NSString *)params
{
    if ([event isEqualToString:@"flutter_event_open_scan"]) {
        UIViewController* hostVC = [UIApplication sharedApplication].delegate.window.rootViewController;
        YYScanViewController *scanVC = [[YYScanViewController alloc] init];
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:scanVC];
        nc.navigationBarHidden = YES;
        [hostVC presentViewController:nc animated:NO completion:nil];
    }
}

@end
