
import SwiftUI

struct LocationView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            Spacer()
            Text(locationManager.locationString)
            Spacer()
            Button {
                locationManager.startLocationServices()
            } label: {
                Text("Start Location Services")
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
