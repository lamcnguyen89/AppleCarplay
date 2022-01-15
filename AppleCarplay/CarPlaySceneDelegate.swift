import Foundation

import Foundation
import CarPlay

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    
  func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                  didConnect interfaceController: CPInterfaceController) {
    
    let screen = CPInformationTemplate(title: "Root", layout: .leading, items: [CPInformationItem(title: "Hello", detail: "CarPlay")], actions: [])
    
    interfaceController.setRootTemplate(screen, animated: true, completion: { _,_ in
        // Do nothing
    })
  }
}
