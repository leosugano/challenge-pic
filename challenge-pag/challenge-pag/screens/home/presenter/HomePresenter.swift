//
//  HomePresenter.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 08/03/21.
//

import Foundation
import UIKit

class HomePresenter: ViewToPresenterHomeProtocol {
    
    //MARK: - Vars
    var view: PresenterToViewHomeProtocol?
    var interactor: PresenterToInteractorHomeProtocol?
    var router: PresenterToRouterHomeProtocol?
    var page: Int = 1
    var beersResponse: [BeerModel]?

    func fetchBeers(pagination: Bool, refresh: Bool) {
        if refresh {
            self.resetPage()
        }
        
        if pagination {
            self.incrementPage()
        }
        
        if !pagination && !refresh {
            self.view?.showLoader()
        }
        
        interactor?.fetchBeers(page: page, pagination: pagination)
    }
    
    func showDetailController(navigationController:UINavigationController, indexPath: IndexPath) {
        if let beer = self.beersResponse?[indexPath.row] {
            router?.pushToDetailScreen(navigationController: navigationController, beer: beer)
        }
    }
    
    //MARK: - Aux methods
    func incrementPage() {
        page += 1
    }
    
    func resetPage() {
        page = 1
    }
}

extension HomePresenter: InteractorToPresenterHomeProtocol {
    func beersFetchedSuccess(response: [BeerModel], pagination: Bool) {
        if pagination {
            self.beersResponse?.append(contentsOf: response)
        } else {
            self.beersResponse = response
        }
        
        self.view?.endLoader()
        self.view?.showBeers()
    }
    
    func beersFetchFailed(message: String) {
        self.view?.endLoader()
        self.router?.showAlert(message: message)
    }
}
