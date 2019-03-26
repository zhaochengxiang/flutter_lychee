
#import "YYRouter.h"
#import <flutter_boost/FlutterBoost.h>

@implementation YYRouter

+ (YYRouter *)sharedRouter
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)openPage:(NSString *)name
          params:(NSDictionary *)params
        animated:(BOOL)animated
      completion:(void (^)(BOOL))completion
{
    UIViewController* vc = nil;
    if ([name hasPrefix:@"flutter://"]) {
        FLBFlutterViewContainer *fvc = FLBFlutterViewContainer.new;
        [fvc setName:name params:params];
        vc = fvc;
    } else if ([name hasPrefix:@"native://"]) {
        NSString* className = [name substringFromIndex:[@"native://" length]];
        
        vc = [[NSClassFromString(className) alloc] initWithNibName:className bundle:[NSBundle mainBundle]];
    }
    
    if([params[@"present"] boolValue]){
        [self.navigationController presentViewController:vc animated:animated completion:^{}];
    } else {
        [self.navigationController pushViewController:vc animated:animated];
    }
}

- (void)closePage:(NSString *)uid animated:(BOOL)animated params:(NSDictionary *)params completion:(void (^)(BOOL))completion
{
    FLBFlutterViewContainer *vc = (id)self.navigationController.presentedViewController;
    if([vc isKindOfClass:FLBFlutterViewContainer.class] && [vc.uniqueIDString isEqual: uid]){
        [vc dismissViewControllerAnimated:animated completion:^{}];
    }else{
        [self.navigationController popViewControllerAnimated:animated];
    }
}
@end
