//
//  HomeRouter.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 08/03/21.
//

import Foundation
import UIKit
import AFNetworking

class HomeRouter: PresenterToRouterHomeProtocol {
   
    //MARK: - Lets
    private static let homeIdentifier = "home"
    private static let mainIdentifier = "Main"
    var viewController: HomeViewController?
    
    //MARK: - Methods
    class func createModule() -> HomeViewController {
        
        guard let view = mainstoryboard.instantiateViewController(withIdentifier: homeIdentifier) as? HomeViewController else {
            return HomeViewController()
        }
        
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        interactor.manager = AFHTTPSessionManager()
        
        router.viewController = view
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
       
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: mainIdentifier,bundle: nil)
    }
    
    func pushToDetailScreen(navigationController:UINavigationController, beer: BeerModel) {
        let beerDetail = DetailRouter.createModule()
        beerDetail.presenter?.beersResponse = beer
        navigationController.pushViewController(beerDetail, animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "error_title".localized(), message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
        self.viewController?.present(alert, animated: true, completion: nil)
    }
}
