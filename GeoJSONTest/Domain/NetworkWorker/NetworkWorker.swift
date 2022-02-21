import Foundation
import Network

protocol NetworkWorkingLogic {
    // Main request to API
    func fetchPosts(response: @escaping (Geometry?) -> Void)
}

class NetworkWorker: NetworkWorkingLogic {
    
    // MARK: - Private Properties
    static let shared = NetworkWorker()
    var isReachable: Bool { status == .satisfied }
    private var status = NWPath.Status.requiresConnection
    
    private let networkService = NetworkSession()
    private let urlString = "https://waadsu.com/api/russia.geo.json"
    
    // MARK: - NetworkWorkingLogic
    func fetchPosts(response: @escaping (Geometry?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let post = try JSONDecoder().decode(ReceivedData.self, from: data)
                    response(post.features.first?.geometry)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
