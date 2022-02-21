import Foundation

protocol MainMapViewPresentationLogic {
    func presentGeoData(response: MapData.LoadGeoData.Response)
}

class MainMapViewPresenter {
    
    var view: MainViewDisplayLogic?
}

extension MainMapViewPresenter: MainMapViewPresentationLogic {
    
    func presentGeoData(response: MapData.LoadGeoData.Response) {
        
        let viewModel = MapData.LoadGeoData.ViewModel(
            coordinates: response.geoData
        )
        view?.displayGeoData(viewModel: viewModel)
    }
}

