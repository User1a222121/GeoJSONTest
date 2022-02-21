import Foundation
import MapKit

protocol MapFactoryProtocol: AnyObject {
    
    func borderLength(data: Geometry) -> Double
    func setPolygonsOnMap(with coordinates: Geometry, view: MKMapView)
}

class MapFactory: MapFactoryProtocol {
    
    // longitude  -180...180 -> 0...360
    private func inverseTransform(with longitude: Double) -> Double {
        
        if longitude > 180 { return -360 + longitude }
        
        return longitude
    }
    
    // calculateDistanceBorderOfPolygons
    private func calculateDistance(
        mobileLocationX: Double,mobileLocationY: Double,
        DestinationX: Double,DestinationY: Double) -> Double {

            let coordinateStart = CLLocation(latitude: mobileLocationX, longitude: mobileLocationY)
            let coordinateEnd = CLLocation(latitude: DestinationX, longitude:  DestinationY)
            let distanceInMeters = coordinateStart.distance(from: coordinateEnd)
            let distanceInKM = distanceInMeters / 1000

            return distanceInKM
    }
    
    // setBorderLength
    func borderLength(data: Geometry) -> Double {
        var lengthOfBorders: Double = 0.0

        for polygon in data.coordinates {
            for points in polygon {
                var distanceOnePolygon: Double = 0.0
                for pointStart in 0...points.count - 2 {
                    let pointEnd = pointStart + 1
                    let distanceBetweenTwoPoints = calculateDistance(mobileLocationX: points[pointStart][1], mobileLocationY: points[pointStart][0], DestinationX: points[pointEnd][1], DestinationY: points[pointEnd][0])
                    distanceOnePolygon += distanceBetweenTwoPoints
                }
                lengthOfBorders += distanceOnePolygon
            }
        }
        return round(lengthOfBorders * 100) / 100
    }
    
    // createOverlay
    func setPolygonsOnMap(with coordinates: Geometry, view: MKMapView) {
        
        var polygons: [MKPolygon] = []
        
        for country in coordinates.coordinates {
            for points in country {
                
                var locations: [CLLocationCoordinate2D] = points.map { CLLocationCoordinate2D(latitude: $0.last!, longitude: inverseTransform(with: $0.first!)) }
                let polygon = MKPolygon(coordinates: &locations, count: locations.count)
                polygons.append(polygon)
            }
        }
        view.addOverlays(polygons)
    }
}

