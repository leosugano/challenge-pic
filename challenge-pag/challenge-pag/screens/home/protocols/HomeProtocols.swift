//
//  HomeProtocols.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 08/03/21.
//

import Foundation
import UIKit

protocol ViewToPresenterHomeProtocol: class {
    var view: PresenterToViewHomeProtocol? {get set}
    var interactor: PresenterToInteractorHomeProtocol? {get set}
    var router: PresenterToRouterHomeProtocol? {get set}
    var beersResponse: [BeerModel]? {get set}
    func fetchBeers(pagination: Bool, refresh: Bool)
    func showDetailController(navigationController:UINavigationController, indexPath: IndexPath)
}

protocol PresenterToViewHomeProtocol: class{
    func showBeers()
    func showLoader()
    func endLoader()
}

protocol PresenterToRouterHomeProtocol: class {
    static func createModule() -> HomeViewController
    func pushToDetailScreen(navigationController:UINavigationController, beer: BeerModel)
    func showAlert(message: String)
}

protocol PresenterToInteractorHomeProtocol: class {
    var presenter: InteractorToPresenterHomeProtocol? {get set}
    func fetchBeers(page: Int, pagination: Bool)
}

protocol InteractorToPresenterHomeProtocol: class {
    func beersFetchedSuccess(response: [BeerModel], pagination: Bool)
    func beersFetchFailed(message: String)
}
