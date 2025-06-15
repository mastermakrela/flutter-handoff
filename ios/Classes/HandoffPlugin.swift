import Flutter
import UIKit
import Foundation

public class HandoffPlugin: NSObject, FlutterPlugin {
    private var currentActivity: NSUserActivity?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.mastermakrela.flutter-handoff", binaryMessenger: registrar.messenger())
        let instance = HandoffPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setHandoffUrl":
            setHandoffUrl(call: call, result: result)
        case "clearHandoff":
            clearHandoff(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func setHandoffUrl(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any],
              let urlString = args["url"] as? String,
              let url = URL(string: urlString) else {
            result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid URL provided", details: nil))
            return
        }

        let title = args["title"] as? String ?? "Browse URL"
        let activityType = "com.mastermakrela.flutter-handoff.browse"

        let activity = NSUserActivity(activityType: activityType)
        activity.title = title
        activity.webpageURL = url
        activity.isEligibleForHandoff = true
        activity.isEligibleForSearch = false
        activity.isEligibleForPublicIndexing = false

        activity.becomeCurrent()
        self.currentActivity = activity

        result(nil)
    }

    private func clearHandoff(result: @escaping FlutterResult) {
        currentActivity?.invalidate()
        currentActivity = nil
        result(nil)
    }
}
