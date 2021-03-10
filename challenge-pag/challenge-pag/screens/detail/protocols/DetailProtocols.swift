//
//  DetailProtocols.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 09/03/21.
//

import Foundation

protocol ViewToPresenterDetailProtocol: class {
    var view: PresenterToViewDetailProtocol? {get set}
    var beersResponse: BeerModel? {get set}
    func showDetailBeer()
}

protocol PresenterToViewDetailProtocol: class {
    func showDetailBeer(beer: BeerModel)
}

protocol PresenterToRouterDetailProtocol: class {
    static func createModule() -> DetailViewController
}
