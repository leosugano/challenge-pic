//
//  DetailRouter.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 09/03/21.
//

import UIKit

class DetailRouter: PresenterToRouterDetailProtocol {
 
    //MARK: - Lets
    private static let homeIdentifier = "detail"
    private static let mainIdentifier = "Main"
    
    //MARK: - Methods
    class func createModule() -> DetailViewController {
        guard let view = mainstoryboard.instantiateViewController(withIdentifier: homeIdentifier) as? DetailViewController else {
            return DetailViewController()
        }
        
        let presenter = DetailPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: mainIdentifier,bundle: nil)
    }
}
