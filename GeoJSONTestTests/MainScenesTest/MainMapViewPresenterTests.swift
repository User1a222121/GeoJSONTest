import XCTest
@testable import GeoJSONTest

class MainMapViewPresenterTests: XCTestCase {

    var sut: MainMapViewPresenter!
    var viewSpy: MainMapViewSpy!

    override func setUpWithError() throws {
    try super.setUpWithError()
    sut = MainMapViewPresenter()
    viewSpy = MainMapViewSpy()
    }

    override func tearDownWithError() throws {
    sut = nil
    viewSpy = nil
    try super.tearDownWithError()
    }
    
    // MARK: - Test doubles
    class MainMapViewSpy: MainViewDisplayLogic  {
        
        
        var geoData: Geometry?
        var displayGeoDataCalled = false
        
        func displayGeoData(viewModel: MapData.LoadGeoData.ViewModel) {
            displayGeoDataCalled = true
            geoData = viewModel.coordinates
        }
        
    }

    // MARK: - Tests
    func testLoadGeoDataCallsPresenterToPresentGeoData() {
        // Given
        sut.view = viewSpy
        let geoData = Seeds.geoData
        // When
        let response = MapData.LoadGeoData.Response(geoData: geoData)
        sut.presentGeoData(response: response)
        // Then
        XCTAssertEqual(
            viewSpy.geoData,
            geoData,
            "displayGeoData(viewModel:) should ask the view to present the same geoData it loaded"
        )
    }
}
