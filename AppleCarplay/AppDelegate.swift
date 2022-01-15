import UIKit
import CarPlay

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
       // return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
        if(connectingSceneSession.role == UISceneSession.Role.carTemplateApplication) {
          let scene =  UISceneConfiguration(name: "CarPlay", sessionRole: connectingSceneSession.role)

          // At the time of writing this blog post there seems to be a bug with the info.plist file where
          // the delegateClass isn't set correctly. So we manually set it here.
          scene.delegateClass = CarPlaySceneDelegate.self
                  
          return scene
         } else {
           let scene =  UISceneConfiguration(name: "Phone", sessionRole: connectingSceneSession.role)
                  
            return scene
         }
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
