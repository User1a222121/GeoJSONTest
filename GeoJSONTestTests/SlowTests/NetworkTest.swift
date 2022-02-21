import XCTest
@testable import GeoJSONTest

class NetworkTest: XCTestCase {
    
    var sut: URLSession!
    let networkWorker = NetworkWorker.shared

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // Asynchronous test
    func testValidApiCallGetsHTTPStatusCode200() throws {
        try XCTSkipUnless(
            networkWorker.isReachable,
            "Network connectivity needed for this test.")
        
        let urlString = "https://waadsu.com/api/russia.geo.json"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sut.dataTask(with: url) { _, response, error in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }

    // Asynchronous test: faster fail
    func testApiCallCompletes() throws {
        try XCTSkipUnless(
              networkWorker.isReachable,
              "Network connectivity needed for this test."
        )

        let urlString = "https://waadsu.com/api/russia.geo.json"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?

        let dataTask = sut.dataTask(with: url) { _, response, error in
                statusCode = (response as? HTTPURLResponse)?.statusCode
                responseError = error
                promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)

        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
