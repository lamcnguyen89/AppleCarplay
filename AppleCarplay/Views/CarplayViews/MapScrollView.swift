import Foundation
import UIKit

/**
 The Coastal Roads map displays as a static image inside a UIScrollView, which enables panning and zooming.
 It supports only a single hardcoded route for navigation, and when the app is in navigation mode,
 the camera viewport animates between several predefined points on the map.
 In a real navigation app that uses a map with tiles, these locations would appear at runtime
 in latitude/longitude format.
 */
enum CRZoomLocation {
    case routeOverview, routeDestination, routeOrigin, routeTurn1, routeTurn2, routeTurn3

    var frame: CGRect {
        switch self {
        case .routeOrigin:
            return CGRect(x: 1000, y: 1000, width: 600, height: 360)
        case .routeOverview:
            return CGRect(x: 0, y: 0, width: 3072, height: 2048)
        case .routeDestination:
            return CGRect(x: 1200, y: 700, width: 600, height: 360)
        case .routeTurn1:
            return CGRect(x: 700, y: 600, width: 600, height: 360)
        case .routeTurn2:
            return CGRect(x: 700, y: 825, width: 600, height: 360)
        case .routeTurn3:
            return CGRect(x: 1200, y: 825, width: 600, height: 360)
        }
    }
}

class MapScrollView: UIScrollView, UIScrollViewDelegate {

    public let imageView: UIImageView

     init(frame: CGRect, image: UIImage) {
        imageView = UIImageView(image: image)

        super.init(frame: frame)

        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)

        contentSize = image.size
        scrollsToTop = false

        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        bounces = false
        bouncesZoom = false

        delegate = self

        let scaleWidth = frame.size.width / image.size.width
        let scaleHeight = frame.size.height / image.size.height
        let minScale = min(scaleWidth, scaleHeight)
        minimumZoomScale = minScale
        maximumZoomScale = 2.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    final func canZoomIn() -> Bool {
        return zoomScale < maximumZoomScale
    }

    final func zoomIn() {
        setZoomScale(zoomScale * 1.5, animated: true)
    }

    final func canZoomOut() -> Bool {
        return zoomScale > minimumZoomScale
    }

    final func zoomOut() {
        setZoomScale(zoomScale * 0.67, animated: true)
    }

    final func zoomToLocation(_ location: CRZoomLocation) {
        zoom(to: location.frame, animated: true)
    }

    // MARK: UIScrollViewDelegate

    final func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

