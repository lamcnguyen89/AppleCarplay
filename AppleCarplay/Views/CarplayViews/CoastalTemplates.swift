
import Foundation
import CarPlay

extension CPGridTemplate {
    
    private typealias GridButton = (title: String, imageName: String)

    static func favoritesGridTemplate(compatibleWith traitCollection: UITraitCollection,
                                      _ buttonHandler: @escaping (CPGridButton) -> Void) -> CPGridTemplate {
        let butttons = [
            GridButton(title: "Parks", imageName: "gridParks"),
            GridButton(title: "Beaches", imageName: "gridBeaches"),
            GridButton(title: "Presents", imageName: "gridPresents"),
            GridButton(title: "Desserts", imageName: "gridDesserts")
        ]

        let gridTemplate = CPGridTemplate(title: "Favorites", gridButtons:
            butttons.map { ( button ) -> CPGridButton in
                return CPGridButton(titleVariants: [button.title],
                                    image: UIImage(named: button.imageName, in: Bundle.main, compatibleWith: traitCollection)!,
                                    handler: buttonHandler)
            })

        return gridTemplate
    }
}

extension CPListTemplate {

    static func searchResultsListTemplate(compatibleWith traitCollection: UITraitCollection,
                                          title: String,
                                          interfaceController: CPInterfaceController?) -> CPListTemplate {

        let item = CPListItem(text: "Jupiter Rd",
                              detailText: "1 Jupiter Rd",
                              image: UIImage(named: "grid\(title)", in: Bundle.main, compatibleWith: traitCollection),
                              accessoryImage: nil,
                              accessoryType: .disclosureIndicator)
        
        item.handler = { item, completion in
            /// In your application, you might extract the destination the user selected rather than navigate to the same place every time :
            // guard let destination = item.userInfo as? MKMapItem else { completionHandler(); return }
            interfaceController?.popToRootTemplate(animated: true) {_, _ in
                TemplateManager.shared.beginNavigation()
            }
        }
        
        let section = CPListSection(items: [item])
        let listTemplate = CPListTemplate(title: title, sections: [section])
        return listTemplate
    }
}

extension CPMapTemplate {

    static func coastalRoadsMapTemplate(compatibleWith traitCollection: UITraitCollection,
                                        zoomInAction: @escaping () -> Void,
                                        zoomOutAction: @escaping () -> Void) -> CPMapTemplate {
        let mapTemplate = CPMapTemplate()

        let zoomInButton = CPMapButton { _ in
            zoomInAction()
        }
        zoomInButton.isHidden = false
        zoomInButton.isEnabled = true
        zoomInButton.image = UIImage(named: "ZoomIn", in: Bundle.main, compatibleWith: traitCollection)

        let zoomOutButton = CPMapButton { _ in
            zoomOutAction()
        }
        zoomOutButton.isHidden = false
        zoomOutButton.isEnabled = true
        zoomOutButton.image = UIImage(named: "ZoomOut", in: Bundle.main, compatibleWith: traitCollection)

        mapTemplate.mapButtons = [zoomInButton, zoomOutButton]
        mapTemplate.automaticallyHidesNavigationBar = false

        return mapTemplate
    }
    
    private typealias Maneuver = (instructions: String, distance: Double, imageName: String)

    func coastalRoadsManeuvers(compatibleWith traitCollection: UITraitCollection) -> [CPManeuver] {
        
        let maneuvers = [
            Maneuver(instructions: "Turn Right on Uranus Ave", distance: 0, imageName: "rightTurn"),
            Maneuver(instructions: "Turn Left on Plant Meadow Blvd", distance: 1000, imageName: "leftTurn"),
            Maneuver(instructions: "Turn Left at Jupiter Rd", distance: 3000, imageName: "leftTurn"),
            Maneuver(instructions: "Your destination is on the right", distance: 500, imageName: "rightTurn")
        ]
        
        return maneuvers.map { maneuver -> CPManeuver in
            let cpManeuver = CPManeuver()
            let estimates = CPTravelEstimates(distanceRemaining: Measurement(value: maneuver.distance, unit: UnitLength.feet), timeRemaining: 300)
            cpManeuver.initialTravelEstimates = estimates
            cpManeuver.instructionVariants = [maneuver.instructions]
            
            if let image = UIImage(named: maneuver.imageName, in: .main, compatibleWith: traitCollection) {
                cpManeuver.symbolImage = image
            }
            
            return cpManeuver
        }
    }

    func simulateCoastalRoadsNavigation(trip: CPTrip, routeChoice: CPRouteChoice, traitCollection: UITraitCollection) -> CPNavigationSession {
        hideTripPreviews()

        let navSession = startNavigationSession(for: trip)

        navSession.pauseTrip(for: .loading, description: "Loading")

        return navSession
    }
}
