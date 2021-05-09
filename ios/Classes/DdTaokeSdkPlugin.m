#import "DdTaokeSdkPlugin.h"
#if __has_include(<dd_taoke_sdk/dd_taoke_sdk-Swift.h>)
#import <dd_taoke_sdk/dd_taoke_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "dd_taoke_sdk-Swift.h"
#endif

@implementation DdTaokeSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDdTaokeSdkPlugin registerWithRegistrar:registrar];
}
@end
