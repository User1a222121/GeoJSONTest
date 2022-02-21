import XCTest
@testable import GeoJSONTest

class MainMapViewControllerTests: XCTestCase {
    
    var sut: MainMapViewController!
    var interactorSpy: CreateIceCreamInteractorSpy!

    override func tearDownWithError() throws {
    sut = nil
    interactorSpy = nil
    try super.tearDownWithError()
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainMapViewController()
        interactorSpy = CreateIceCreamInteractorSpy()
    }

    // MARK: - Test doubles
    class CreateIceCreamInteractorSpy: MainMapViewBusinessLogic {
        
        var loadGeoDataCalled = false
        
        func loadGeoData(request: MapData.LoadGeoData.Request) {
            loadGeoDataCalled = true
            
        }
    }

    // MARK: - Tests
    func testShouldLoadIceCreamOnViewAppear() {
        // Given
        sut.interactor = interactorSpy
        // When
        sut.fetchGeoData()
        // Then
        XCTAssertTrue(
            interactorSpy.loadGeoDataCalled,
            "fetchIceCream() should ask the interactor to load the ice cream"
        )
    }
}

