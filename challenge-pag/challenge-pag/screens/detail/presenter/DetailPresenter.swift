//
//  DetailPresenter.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 09/03/21.
//

import Foundation

import UIKit

class DetailPresenter: ViewToPresenterDetailProtocol {
    var view: PresenterToViewDetailProtocol?
    var beersResponse: BeerModel?
    
    func showDetailBeer() {
        if let beer = beersResponse {
            self.view?.showDetailBeer(beer: beer)
        }
    }
    
}
