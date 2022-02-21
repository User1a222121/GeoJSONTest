import Foundation

enum MapData {
  enum LoadGeoData {
    struct Request {}

    struct Response {
      var geoData: Geometry
    }

    struct ViewModel {
        var coordinates: Geometry
    }
  }
}
