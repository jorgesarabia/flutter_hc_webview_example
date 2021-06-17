import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

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
      guard call.method == "nativeWebView" else {
        result(FlutterMethodNotImplemented)
        return
      }
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"MyViewController") as UIViewController
        viewController.modalPresentationStyle = .fullScreen

        controller.present(viewController, animated: false, completion: nil)
        
    
      //self.openWebView(result: result)
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

//  private func openWebView(result: FlutterResult){
//    result("No URL")
//  }
}
