

import SwiftUI

struct DetailView: View {
    private let location: Place
    @StateObject private var snapshotter: SnapShotter
    
    var body: some View {
        VStack {
            TitleView(locationName: location.name)
            LocationPhoto(photoName: location.image)
            ScrollView {
                Text(location.details)
                    .font(.body)
                Image(uiImage: snapshotter.isOnDevice ? snapshotter.mapSnapShot! : snapshotter.defaultMap)
                    .resizable()
                    .padding(.bottom)
            }
            .padding(.top)
        }
        .padding(.top, -60)
        .padding(.horizontal)
        .background(RoadView())
        .onAppear(perform: loadMapSnapshot)
    }
    
    init(location: Place) {
        self.location = location
        _snapshotter = StateObject(wrappedValue: SnapShotter(imageName: location.image, region: location.region))
    }
    
    func loadMapSnapshot() {
        if !snapshotter.isOnDevice {
            snapshotter.takeSnapShot()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(location: MapDirectory().places[1])
    }
}
