import UIKit

extension MainMapViewController {
    func setup() {
        let viewController = self
        let interactor = MainMapViewInteractor()
        let presenter = MainMapViewPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
    }
}
