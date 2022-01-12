
import SwiftUI
import MapKit

@main
struct AppleCarplayApp: App {
  
  var body: some Scene {
    WindowGroup {
      ContentView(places: MapDirectory().places)
    }
  }
}
