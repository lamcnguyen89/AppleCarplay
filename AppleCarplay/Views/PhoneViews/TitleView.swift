

import SwiftUI

struct TitleView: View {
  let locationName: String

  var body: some View {
    Text(locationName)
        .font(.largeTitle)
        .fontWeight(.heavy)
        .multilineTextAlignment(.center)
        .lineLimit(3)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .shadow(color: .black, radius: 1, x: 1, y: -2)
  }
}

struct TitleView_Previews: PreviewProvider {
  static var previews: some View {
    TitleView(locationName: "Location Name")
      .background(Color.gray)
  }
}
