

import Foundation

import Foundation
import UIKit
import SwiftUI

@available(iOS 14, *)
class PhoneSceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
  let contentView = ContentView(places: MapDirectory().places)
    
  if let windowScene = scene as? UIWindowScene {
     let window = UIWindow(windowScene: windowScene)
     window.rootViewController = UIHostingController(rootView: contentView)
     self.window = window
     window.makeKeyAndVisible()
  }
}
}

