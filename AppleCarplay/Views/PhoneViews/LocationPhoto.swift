

import SwiftUI

struct LocationPhoto: View {
  let photoName: String

  var body: some View {
    Image(photoName)
      .resizable()
      .cornerRadius(10)
      .aspectRatio(contentMode: .fit)
      .frame(maxHeight: 200)
      .padding(5)
     // .background(Color.white)
     // .border(Color.black, width: 2)
      .padding(.top)
    //  .rotationEffect(.degrees(.random(in: -5 ... 5)), anchor: .center)
  }
}

struct LocationPhoto_Previews: PreviewProvider {
  static var previews: some View {
    LocationPhoto(photoName: "holenrock")
  }
}
