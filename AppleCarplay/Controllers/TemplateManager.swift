import CarPlay
import Foundation
import os

class TemplateManager: NSObject, CPInterfaceControllerDelegate, CPSessionConfigurationDelegate {
    
    static let shared = TemplateManager()

    private var carplayInterfaceController: CPInterfaceController?
    private var carWindow: UIWindow?

    public private(set) var baseMapTemplate: CPMapTemplate?

    var currentTravelEstimates: CPTravelEstimates?
    var navigationSession: CPNavigationSession?
    var displayLink: CADisplayLink?
    var activeManeuver: CPManeuver?
    var activeEstimates: CPTravelEstimates?
    var lastCompletedManeuverFrame: CGRect?
    var sessionConfiguration: CPSessionConfiguration!
    
    let mapViewController = MapViewController()

    override init() {
        super.init()
        sessionConfiguration = CPSessionConfiguration(delegate: self)
        mapViewController.mapViewActionProvider = self
    }

    // MARK: CPInterfaceControllerDelegate
    
    func listTemplate(_ listTemplate: CPListTemplate, didSelect item: CPListItem, completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func templateWillAppear(_ aTemplate: CPTemplate, animated: Bool) {
        
    }

    func templateDidAppear(_ aTemplate: CPTemplate, animated: Bool) {
        
    }

    func templateWillDisappear(_ aTemplate: CPTemplate, animated: Bool) {
        
    }

    func templateDidDisappear(_ aTemplate: CPTemplate, animated: Bool) {
        
    }

    // MARK: CPSessionConfigurationDelegate

    func sessionConfiguration(_ sessionConfiguration: CPSessionConfiguration,
                              limitedUserInterfacesChanged limitedUserInterfaces: CPLimitableUserInterface) {
        
    }

    // MARK: CPMapTemplateDelegate

    func mapTemplateDidShowPanningInterface(_ mapTemplate: CPMapTemplate) {
        
    }

    func mapTemplateDidDismissPanningInterface(_ mapTemplate: CPMapTemplate) {
        
    }
    
    // MARK: CPTemplateApplicationDashboardSceneDelegate
    
    func dashboardController(_ dashboardController: CPDashboardController, didConnectWith window: UIWindow) {
        
        
        let aButton = CPDashboardButton(
            titleVariants: ["Beaches"],
            subtitleVariants: ["Beach Trip"],
            image: #imageLiteral(resourceName: "gridBeaches")) { (button) in
                self.beginNavigation()
        }
        
        let bButton = CPDashboardButton(
            titleVariants: ["Parks"],
            subtitleVariants: ["Park Trip"],
            image: #imageLiteral(resourceName: "gridParks")) { (button) in
                self.beginNavigation()
        }

        // Use a separate view controller for the dashboard scene.
        window.rootViewController = MapViewController()
        
        dashboardController.shortcutButtons = [aButton, bButton]
    }

    func dashboardController(_ dashboardController: CPDashboardController, didDisconnectWith window: UIWindow) {
        
    }

    /// - Tag: did_connect
    // MARK: CPTemplateApplicationSceneDelegate
    
    func interfaceController(_ interfaceController: CPInterfaceController, didConnectWith window: CPWindow) {
        

        carplayInterfaceController = interfaceController
        carplayInterfaceController!.delegate = self
        
        window.rootViewController = mapViewController

        carWindow = window

        let mapTemplate = CPMapTemplate.coastalRoadsMapTemplate(compatibleWith: mapViewController.traitCollection, zoomInAction: {
            self.mapViewController.zoomIn()
        }, zoomOutAction: {
            self.mapViewController.zoomOut()
        })

        mapTemplate.mapDelegate = self

        baseMapTemplate = mapTemplate

        installBarButtons()

        interfaceController.setRootTemplate(mapTemplate, animated: true) { (_, _) in }
    }

    func interfaceController(_ interfaceController: CPInterfaceController, didDisconnectWith window: CPWindow) {
    
        carplayInterfaceController = nil
        carWindow?.isHidden = true
    }

    // MARK: Template Generators

    func showGridTemplate() {
        let gridTemplate = CPGridTemplate.favoritesGridTemplate(compatibleWith: mapViewController.traitCollection) {
            // Set title if it exists, otherwise name it "Favorites".
            button in self.showListTemplate(title: button.titleVariants.first ?? "Favorites")
        }

        carplayInterfaceController?.pushTemplate(gridTemplate, animated: true) { (_, _) in }
    }

    func showListTemplate(title: String) {
        let listTemplate = CPListTemplate.searchResultsListTemplate(
            compatibleWith: mapViewController.traitCollection,
            title: title,
            interfaceController: carplayInterfaceController)
        carplayInterfaceController?.pushTemplate(listTemplate, animated: true) { (_, _) in }
    }
}

