
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <flutter_boost/FLBPlatform.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYRouter : NSObject<FLBPlatform>

@property (nonatomic,strong) UINavigationController *navigationController;

+ (YYRouter *)sharedRouter;


@end

NS_ASSUME_NONNULL_END
