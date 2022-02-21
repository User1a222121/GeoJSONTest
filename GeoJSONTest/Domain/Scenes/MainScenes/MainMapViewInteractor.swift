import Foundation

protocol MainMapViewBusinessLogic {
    
    func loadGeoData(request: MapData.LoadGeoData.Request)
}

class MainMapViewInteractor {
    
    var presenter: MainMapViewPresentationLogic?
    var networkWorker: NetworkWorkingLogic = NetworkWorker()
}

extension MainMapViewInteractor: MainMapViewBusinessLogic {
    
    func loadGeoData(request: MapData.LoadGeoData.Request) {
        
        networkWorker.fetchPosts { (data) in
            guard let receivedData = data else { return }
            let response = MapData.LoadGeoData.Response(geoData: receivedData)
            self.presenter?.presentGeoData(response: response)
        }
    }
}

