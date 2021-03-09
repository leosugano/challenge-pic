//
//  HomeInteractor.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 08/03/21.
//

import UIKit
import AFNetworking
import Mantle

class HomeInteractor: PresenterToInteractorHomeProtocol{
    
    //MARK: - Lets
    let base_url = "https://api.punkapi.com/v2/beers"
    let manager = AFHTTPSessionManager()

    //MARK: - Vars
    var presenter: InteractorToPresenterHomeProtocol?
    
    //MARK: - Metods
    func fetchBeers(page: Int, pagination: Bool) {
        let parameters: [String : Any]  = [
            "page" : page
        ]
        
        manager.get(base_url, parameters: parameters, progress: nil) { [weak self] (operation, responseObject) in
            if let response = responseObject as? NSArray {
                let responseArray: NSMutableArray = []
                
                for item in response {
                    guard let model = try? MTLJSONAdapter.model(of: BeerModel.self, fromJSONDictionary: item as? [AnyHashable : Any]) else {
                        self?.presenter?.beersFetchFailed(message: "error_conversion".localized())
                        return
                    }
                    responseArray.add(model)
                }
                
                if let responseSuccess = responseArray as? [BeerModel] {
                    self?.presenter?.beersFetchedSuccess(response: responseSuccess, pagination: pagination)
                } else {
                    self?.presenter?.beersFetchFailed(message: "error_conversion".localized())
                }
            }
        } failure: { [weak self] (operation, errorMessage) in
            self?.presenter?.beersFetchFailed(message: errorMessage.localizedDescription)
        }
    }
}
