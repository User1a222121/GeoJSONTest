import Foundation
import MapKit

public protocol MapViewProtocol {

    func didTapMKPolygons(_ mapView: MKMapView, _ selectPolygon: MKPolygon)
}

public class MapView: MKMapView {

    public var mapViewProtocol: MapViewProtocol?
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first {
            if touch.tapCount == 1 {

                let touchLocation: CGPoint = touch.location(in: self)
                let locationCoordinate: CLLocationCoordinate2D = self.convert(touchLocation, toCoordinateFrom: self)
                var mkPolygonList: [MKPolygon] = self.overlays.compactMap { $0 as? MKPolygon }
                mkPolygonList = mkPolygonList.filter { $0.contains(locationCoordinate) }
                
                if !mkPolygonList.isEmpty {
                    self.mapViewProtocol?.didTapMKPolygons(self, mkPolygonList.first!)
                }
            }
        }
    super.touchesEnded(touches, with: event)
    }
    
    // setCenterToLocation
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance) {
        
    let coordinateRegion = MKCoordinateRegion(
        center: location.coordinate,
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
    
//MARK: - extension MKPolygon
extension MKPolygon {

    func contains(_ coordinate2D: CLLocationCoordinate2D) -> Bool {

        let renderer = MKPolygonRenderer(polygon: self)
        let currentMapPoint: MKMapPoint = MKMapPoint(coordinate2D)
        let viewPoint: CGPoint = renderer.point(for: currentMapPoint)
        if renderer.path == nil {

            return false
        } else {
            return renderer.path.contains(viewPoint)
        }
    }
}

//MARK: - extension MKMultiPolygon
extension MKMultiPolygon {

    func contains(_ coordinate2D: CLLocationCoordinate2D) -> Bool {
        
        return self.polygons.filter { $0.contains(coordinate2D) }.isEmpty ? false : true
    }
}


