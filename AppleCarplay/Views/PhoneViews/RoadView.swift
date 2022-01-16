

import SwiftUI

struct RoadView: View {
  var body: some View {
    ZStack {
      Color.gray
    
      Image("road")
      .resizable()
      .aspectRatio(contentMode: .fill)
      .opacity(0.3)
    }
    .edgesIgnoringSafeArea(.all)
  }
}

struct RoadView_Previews: PreviewProvider {
  static var previews: some View {
    RoadView()
  }
}
