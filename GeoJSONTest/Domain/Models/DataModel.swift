import Foundation

struct ReceivedData: Decodable {
    let features: [Feature]
}

struct Feature: Decodable {
    let geometry: Geometry
}

struct Geometry: Decodable, Equatable {
    var coordinates: [[[[Double]]]]
}
