import Flutter
import UIKit
import ActivityKit

public class SwiftLiveActivitiesPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "live_activities", binaryMessenger: registrar.messenger())
        let instance = SwiftLiveActivitiesPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    func saveImage(image: UIImage, name: String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("\(name).png")!)

            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            print("[download img] path: \(dir.absoluteString)")
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }

    func downloadImage(urlString: String, name: String) {
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {

                let image = self.getSavedImage(named: "btc")

                if(image == nil) {
                    self.saveImage(image: UIImage(data: data)!, name: name)
                    print("[download img] download success")
                }

            }
        }
        task.resume()
    }


    func getImage() {

    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if #available(iOS 16.1, *) {
            switch (call.method) {
            case "createActivity":
                guard let args = call.arguments as? [String: Any] else {
                    return
                }
                if let data = args["data"] as? Dictionary<String, String> {
                    createActivity(data: data, result: result)

                    let url = (data["image"] ?? "")as String
                    let name = (data["symbol"] ?? "")as String
                    print("[download img] \(name) \(url)")
                    print("[download img] \(data)")
                    downloadImage(urlString: url, name: name)


                } else {
                    result(FlutterError(code: "WRONG_ARGS", message: "argument are not valid, check if 'data' is valid", details: nil))
                }
                break
            case "updateActivity":
                guard let args = call.arguments as? [String: Any] else {
                    return
                }
                if let activityId = args["activityId"] as? String, let data = args["data"] as? Dictionary<String, String> {
                    updateActivity(activityId: activityId, data: data, result: result)
                } else {
                    result(FlutterError(code: "WRONG_ARGS", message: "argument are not valid, check if 'activityId' & 'data' are valid", details: nil))
                }
                break
            case "endActivity":
                guard let args = call.arguments as? [String: Any] else {
                    return
                }
                if let activityId = args["activityId"] as? String {
                    endActivity(activityId: activityId, result: result)
                } else {
                    result(FlutterError(code: "WRONG_ARGS", message: "argument are not valid, check if 'activityId' is valid", details: nil))
                }
                break

            default:
                break
            }
        } else {
            result(FlutterError(code: "WRONG_IOS_VERSION", message: "this version of iOS is not supported", details: nil))
        }
    }

    @available(iOS 16.1, *)
    func createActivity(data: Dictionary<String, String>, result: @escaping FlutterResult) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in

            if let error = error {
                result(FlutterError(code: "AUTHORIZATION_ERROR", message: "authorization error", details: error.localizedDescription))
            }
        }

        let liveDeliveryAttributes = LiveActivitiesAppAttributes()
        let initialContentState = LiveActivitiesAppAttributes.LiveDeliveryData(data: data)

        do {
            let deliveryActivity = try Activity<LiveActivitiesAppAttributes>.request(
                attributes: liveDeliveryAttributes,
                contentState: initialContentState,
                pushType: nil)
            result(deliveryActivity.id)
        } catch (let error) {
            result(FlutterError(code: "LIVE_ACTIVITY_ERROR", message: "can't launch live activity", details: error.localizedDescription))
        }
    }

    @available(iOS 16.1, *)
    func updateActivity(activityId: String, data: Dictionary<String, String>, result: @escaping FlutterResult) {
        Task {
            for activity in Activity<LiveActivitiesAppAttributes>.activities {
                if (activityId == activity.id) {
                    let updatedStatus = LiveActivitiesAppAttributes.LiveDeliveryData(data: data)
                    await activity.update(using: updatedStatus)
                    break;
                }
            }
        }
    }

    @available(iOS 16.1, *)
    func endActivity(activityId: String, result: @escaping FlutterResult) {
        Task {
            for activity in Activity<LiveActivitiesAppAttributes>.activities {
                if (activityId == activity.id) {
                    await activity.end(dismissalPolicy: .immediate)
                    break;
                }
            }
        }
    }

    struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
        public typealias LiveDeliveryData = ContentState

        public struct ContentState: Codable, Hashable {
            // TODO: Need to send an Any object
            var data: Dictionary<String, String>
        }

        var id = UUID()
    }
}
