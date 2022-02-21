import XCTest
@testable import GeoJSONTest

class BusinnesLogicTest: XCTestCase {
    
    var sut: MapFactory!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MapFactory()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testBoundaryCalculation() {
        
        let TwoPoint = Seeds.geoData
        
        let borderLength = sut.borderLength(data: TwoPoint)
        
        XCTAssertEqual(borderLength, 223.19, "Calculation computed from boundary is wrong")
    }
}
