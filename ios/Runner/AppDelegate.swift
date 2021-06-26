import UIKit
import Flutter

protocol MyProtocol {
    func onInteractionFinish(type: String)
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MyProtocol {
    
    var flutterResult:FlutterResult?
    

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
        if ("nativeWebView" == call.method) {
            self.flutterResult = result
            
            let viewController:ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"MyViewController") as! ViewController
            viewController.delegate = self
            viewController.initialUrl = call.arguments as! String
            
            
            
            // Open with navigator
//            let navigationController = UINavigationController(rootViewController: viewController)
//            navigationController.navigationBar.topItem?.title = "Platform View"
//            controller.present(navigationController, animated: true, completion: nil)
            
            // Open as a modal
             viewController.modalPresentationStyle = .fullScreen
             controller.present(viewController, animated: true, completion: nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func onInteractionFinish(type: String){
        if let unwrapped = flutterResult {
            unwrapped(type)
        }
    }
}

extension FlutterViewController {
    open override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)
    }
    
    open override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        super.pressesEnded(presses, with: event)
    }
    
    open override func pressesCancelled(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        super.pressesCancelled(presses, with: event)
    }
}
