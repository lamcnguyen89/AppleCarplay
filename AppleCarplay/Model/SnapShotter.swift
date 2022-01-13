

import Foundation
import MapKit
import UIKit

final class SnapShotter: ObservableObject {
    
    let defaultMap: UIImage
    private(set) var mapSnapShot: UIImage?
    private let imageName: String
    private let region: MKCoordinateRegion
    private let fileLocation: URL
    private let options: MKMapSnapshotter.Options
    private var mapSnapshotter : MKMapSnapshotter?
    
    @Published private(set) var isOnDevice = false

    init(imageName: String, region: MKCoordinateRegion) {
        
        self.imageName = imageName
        self.region = region
        
        guard let map = UIImage(named: "map.png") else {
            fatalError("Missing default map")
        }
        self.defaultMap = map
        options = MKMapSnapshotter.Options()
        options.region = region
        options.size = CGSize(width: 200, height: 200)
        options.scale = UIScreen.main.scale
        let fileManager = FileManager.default
        guard let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            fatalError("Unable to get file.")
        }
        fileLocation = url.appendingPathComponent("\(imageName).png")
        if fileManager.fileExists(atPath: fileLocation.path), let image = UIImage(contentsOfFile: fileLocation.path) {
            mapSnapShot = image
            isOnDevice = true
        }
    }
    
    func takeSnapShot() {
        mapSnapshotter = MKMapSnapshotter(options: options)
        mapSnapshotter?.start {
            snapshot, error in
            guard let snapshot = snapshot else {
                fatalError("Unable to take snapshot")
            }
            let imageData = snapshot.image.pngData()
            guard let data = imageData, let imageSnapshot = UIImage(data: data) else {
                fatalError("Unable to produce map image")
            }
            DispatchQueue.main.async { [weak self] in
                self?.isOnDevice = true
                self?.writeToDisk(imageData: data)
                self?.mapSnapShot = imageSnapshot
                
            }
        }
    }
    
    func writeToDisk(imageData: Data) {
        do {
            try imageData.write(to: fileLocation)
        } catch {
            fatalError("Unable to write file")
        }
    }
}
