

import Foundation

struct MapDirectory {
  let places: [Place] = {
    guard let json = Bundle.main.url(forResource: "places", withExtension: ".json") else {
      fatalError("Unable to load json")
    }
    do {
      let jsonData = try Data(contentsOf: json)
      return try JSONDecoder().decode([Place].self, from: jsonData)
    } catch {
      fatalError("Unable to load or parse json file from bundle")
    }
  } ()
}
