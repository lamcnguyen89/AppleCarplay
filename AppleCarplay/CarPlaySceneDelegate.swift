import Foundation

import Foundation
import CarPlay

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    
//  func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
//                                  didConnect interfaceController: CPInterfaceController) {
//    let screen = CPInformationTemplate(title: "Root", layout: .leading, items: [CPInformationItem(title: "Hello", detail: "CarPlay")], actions: [])
//    interfaceController.setRootTemplate(screen, animated: true, completion: { _,_ in
//        // Do nothing
//    })
//
//  }
    
    var interfaceController: CPInterfaceController?
    
    // Carplay connected
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
        self.interfaceController = interfaceController
        
        //creating the tab sections
        let tabFavs = CPListItem(text: "Favorites", detailText: "subtitle for Favorites")
        let tabRecent = CPListItem(text: "Most Recent", detailText: "subtitle for Most Recent")
        let tabHistory = CPListItem(text: "History", detailText: "subtitle for History")
        let tabSearch = CPListItem(text: "Search", detailText: "subtitle for Search")
        
        // adding the above tabs in section
        let sectionItemsA = CPListSection(items: [tabFavs, tabRecent, tabHistory, tabSearch])
        let sectionItemsB = CPListSection(items: [tabFavs, tabHistory])
        
        let listTemplate = CPListTemplate(title: "", sections: [sectionItemsA])
        let listTemplateA = CPListTemplate(title: "", sections: [sectionItemsB])
        let listTemplateB = CPListTemplate(title: "", sections: [sectionItemsA])
        let listTemplateC = CPListTemplate(title: "", sections: [sectionItemsB])
        
        // Creating Tabs
        let tabA: CPListTemplate = listTemplate
        tabA.tabSystemItem = .favorites
        tabA.showsTabBadge = false
        
        let tabB: CPListTemplate = listTemplateA
        tabB.tabSystemItem = .mostRecent
        tabB.showsTabBadge = true
        
        let tabC: CPListTemplate = listTemplateB
        tabC.tabSystemItem = .history
        tabC.showsTabBadge = false
        
        let tabD: CPListTemplate = listTemplateC
        tabD.tabSystemItem = .search
        tabD.showsTabBadge = false
        
        let tabBarTemplate = CPTabBarTemplate(templates: [tabA, tabB, tabC, tabD])
        self.interfaceController?.setRootTemplate(tabBarTemplate, animated: true)
        
    }
    
    // CarPlay disconnected
    private func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnect interfaceController: CPInterfaceController) {
        print("Carplay disconnected. Goodbye!!")
        self.interfaceController = nil
    }
    
}
