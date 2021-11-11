import Flutter
import UIKit

public class SwiftFlutterDdDataokeSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_dd_dataoke_sdk", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterDdDataokeSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
