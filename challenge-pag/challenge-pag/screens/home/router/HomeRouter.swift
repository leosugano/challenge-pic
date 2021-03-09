//
//  HomeRouter.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 08/03/21.
//

import Foundation
import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {
   
    //MARK: - Lets
    private static let homeIdentifier = "home"
    private static let mainIdentifier = "Main"
    
    //MARK: - Methods
    static func createModule() -> HomeViewController {
        
        guard let view = mainstoryboard.instantiateViewController(withIdentifier: homeIdentifier) as? HomeViewController else {
            return HomeViewController()
        }
        
        let presenter: ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol = HomePresenter()
        let interactor: PresenterToInteractorHomeProtocol = HomeInteractor()
        let router: PresenterToRouterHomeProtocol = HomeRouter()
        
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
    
    
    func pushToDetailScreen(navigationConroller:UINavigationController, beer: BeerModel) {

    }
    
//    func pushToMovieScreen(navigationConroller navigationController:UINavigationController) {
//
//        let movieModue = MovieRouter.createMovieModule()
//        navigationController.pushViewController(movieModue,animated: true)
//
//    }
    
}
