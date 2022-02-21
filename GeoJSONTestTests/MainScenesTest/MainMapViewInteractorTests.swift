import XCTest
@testable import GeoJSONTest

class MainMapViewInteractorTests: XCTestCase {

    var sut: MainMapViewInteractor!
    var presenterSpy: MainMapViewPresenterSpy!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainMapViewInteractor()
        presenterSpy = MainMapViewPresenterSpy()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        presenterSpy = nil
        try super.tearDownWithError()
    }

    // MARK: - Test doubles
    
    class MainMapViewPresenterSpy: MainMapViewPresentationLogic {
        
        var geoData = Seeds.geoData
        var presentGeoDataCalled = false
        
        func presentGeoData(response: MapData.LoadGeoData.Response) {
            presentGeoDataCalled = true
        }
    }

    // MARK: - Tests
    func testLoadGeoDataCallsPresenterToPresentGeoData() {
        // Given
        sut.presenter = presenterSpy
        let geoData = Seeds.geoData
        // When
        let request = MapData.LoadGeoData.Request()
        sut.loadGeoData(request: request)
        // Then
        XCTAssertEqual(
            presenterSpy.geoData,
            geoData,
            "presentGeoData(response:) should ask the presenter to present the same geoData it loaded"
        )
    }
}
