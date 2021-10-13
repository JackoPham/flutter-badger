#import "FlutterBadgerPlugin.h"
#if __has_include(<flutter_badger/flutter_badger-Swift.h>)
#import <flutter_badger/flutter_badger-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_badger-Swift.h"
#endif

@implementation FlutterBadgerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"tuna/flutter_badger"
            binaryMessenger:[registrar messenger]];
  FlutterBadgerPlugin* instance = [[FlutterBadgerPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)enableNotifications {
    UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    [self enableNotifications];
    
  if ([@"updateBadgeCount" isEqualToString:call.method]) {
      NSDictionary *args = call.arguments;
      NSNumber *count = [args objectForKey:@"count"];
      [UIApplication sharedApplication].applicationIconBadgeNumber = count.integerValue;
    result(nil);
  } else if ([@"removeBadge" isEqualToString:call.method]) {
      [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
      result(nil);
  } else if ([@"isAppBadgeSupported" isEqualToString:call.method]) {
      result(@YES);
  } else {
    result(FlutterMethodNotImplemented);
  }
}
@end
