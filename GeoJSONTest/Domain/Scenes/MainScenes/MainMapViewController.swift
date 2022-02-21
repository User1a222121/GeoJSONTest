import UIKit
import MapKit
import Foundation

protocol MainViewDisplayLogic {
    
    func displayGeoData(viewModel: MapData.LoadGeoData.ViewModel)
}

// MARK: - extension MainViewDisplayLogic
extension MainMapViewController: MainViewDisplayLogic {
    
    func displayGeoData(viewModel: MapData.LoadGeoData.ViewModel) {
        mapFactory.setPolygonsOnMap(with: viewModel.coordinates, view: mapView)
        borderLengthLabel.text = "Length of borders - \(mapFactory.borderLength(data: viewModel.coordinates))km"
        borderLengthLabel.isHidden = false
        statusLabel.isHidden = true
        activityIndicator.stopAnimating()
    }
}

class MainMapViewController: UIViewController {
    
    // MARK: - Propirties
    let initialLocation = CLLocation(latitude: 85, longitude: 70)
    var interactor: MainMapViewBusinessLogic?
    var mapFactory: MapFactoryProtocol = MapFactory()
    var selectPolygon: [MKPolygon] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    let mapView: MapView = {
        let mapView = MapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let borderLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 1
        label.isHidden = true
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.textColor = .systemGray
        label.numberOfLines = 1
        label.isHidden = false
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.style = UIActivityIndicatorView.Style.large
        return activity
    }()
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.startAnimating()
        fetchGeoData()
        setupUI()
    }
    
    // MARK: - Func
    
    func fetchGeoData() {
        let request = MapData.LoadGeoData.Request()
        interactor?.loadGeoData(request: request)
        statusLabel.text = "Загрузка данных с сервера"
    }
    
    private func setupUI() {

        self.view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        self.view.addSubview(borderLengthLabel)
        NSLayoutConstraint.activate([
            borderLengthLabel.topAnchor.constraint(equalTo: self.mapView.topAnchor, constant: 50),
            borderLengthLabel.leftAnchor.constraint(equalTo: self.mapView.leftAnchor),
            borderLengthLabel.rightAnchor.constraint(equalTo: self.mapView.rightAnchor)
        ])
        
        self.view.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: self.mapView.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -30)
        ])
        
        mapView.centerToLocation(initialLocation, regionRadius: 100000)
        mapView.delegate = self
        mapView.mapViewProtocol = self
    }
}

// MARK: - extension MKMapViewDelegate
extension MainMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if !self.selectPolygon.isEmpty {
            let polygon = MKPolygonRenderer(overlay: selectPolygon.first!)
            polygon.fillColor = UIColor(red: 150/255, green: 26/255, blue: 34/255, alpha: 1)
            polygon.lineWidth = 1
            polygon.strokeColor = UIColor(red: 150/255, green: 26/255, blue: 34/255, alpha: 1)

            return polygon
        } else {
            let polygon = MKPolygonRenderer(overlay: overlay)
            polygon.fillColor = UIColor(red: 29/255, green: 123/255, blue: 243/255, alpha: 0.50)
            polygon.lineWidth = 1
            polygon.strokeColor = UIColor(red: 150/255, green: 26/255, blue: 34/255, alpha: 1)

            return polygon
        }
    }
}

// MARK: - extension MapViewProtocol
extension MainMapViewController: MapViewProtocol {
    
    func didTapMKPolygons(_ mapView: MKMapView, _ selectPolygon: MKPolygon) {
        
        if !self.selectPolygon.isEmpty {
            mapView.addOverlay(self.selectPolygon.removeFirst())
        }
        
        mapView.removeOverlay(selectPolygon)
        self.selectPolygon.append(selectPolygon)
        mapView.addOverlay(selectPolygon)
    }
}




