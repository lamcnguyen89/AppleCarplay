

import SwiftUI

struct DetailView: View {
  private let location: Place

  var body: some View {
    VStack {
      TitleView(locationName: location.name)
      LocationPhoto(photoName: location.image)
      ScrollView {
        Text(location.details)
          .font(.body)
      }
      .padding(.top)
    }
    .padding(.top, -60)
    .padding(.horizontal)
    .background(RoadView())
  }
  
  init(location: Place) {
    self.location = location
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(location: MapDirectory().places[1])
  }
}
