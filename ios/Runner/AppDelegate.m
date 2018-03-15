#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include <sys/sysctl.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  
  // Override point for customization after application launch.
    FlutterViewController *controller = (FlutterViewController *) self.window.rootViewController;
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel
                                           methodChannelWithName:@"sparkle-cherry.io/native-calls-example"
                                           binaryMessenger:controller];
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([@"getOsVersion" isEqualToString:call.method]) {
            result([self osVersion]);
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
  
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (NSString *) osVersion {
    return [[[[@"iOS " stringByAppendingString:[self osVersionNumber]] stringByAppendingString:@" ("] stringByAppendingString:[self osVersionBuild]] stringByAppendingString:@")"];
}

- (NSString *) osVersionNumber {
    return [UIDevice.currentDevice systemVersion];
}

- (NSString *) osVersionBuild {
    int mib[2] = {CTL_KERN, KERN_OSVERSION};
    u_int namelen = sizeof(mib) / sizeof(mib[0]);
    size_t bufferSize = 0;
    
    NSString *osBuildVersion = nil;
    
    // Get the size for the buffer
    sysctl(mib, namelen, NULL, &bufferSize, NULL, 0);
    
    u_char buildBuffer[bufferSize];
    int result = sysctl(mib, namelen, buildBuffer, &bufferSize, NULL, 0);
    
    if (result >= 0) {
        osBuildVersion = [[NSString alloc] initWithBytes:buildBuffer length:bufferSize encoding:NSUTF8StringEncoding];
    }
    return osBuildVersion;
}

@end
