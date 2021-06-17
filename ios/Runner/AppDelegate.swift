import UIKit
import Flutter

protocol MyProtocol {
    func onInteractionFinish(type: String)
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MyProtocol {
    
    var flutterResult:FlutterResult? = nil
    

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "ejemplo.hybrid.composition.webview",
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        self.flutterResult = result
      guard call.method == "nativeWebView" else {
        result(FlutterMethodNotImplemented)
        return
      }
        let viewController:ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"MyViewController") as! ViewController
        viewController.modalPresentationStyle = .fullScreen
        viewController.delegate = self

        controller.present(viewController, animated: false, completion: nil)
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func onInteractionFinish(type: String){
        if let unwrapped = flutterResult {
            unwrapped(type)
        }
    }
}
