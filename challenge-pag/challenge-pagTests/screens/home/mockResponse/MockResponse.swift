//
//  MockResponse.swift
//  challenge-pagTests
//
//  Created by Leonardo Sugano on 10/03/21.
//

import Foundation
@testable import challenge_pag

class MockResponse {
    static func getBeerDictionaryMock() -> [BeerModel] {
        let myDict: NSDictionary = [
            "name": "Buzz",
            "tagline": "A Real Bitter Experience.",
            "descriptionBeer": "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
            "imageBeer": "https://images.punkapi.com/v2/keg.png",
            "alcoholContent": 4.5,
            "bitternessScale": 60,
        ]
        
        if let dict = myDict as? [AnyHashable : Any], let mock = try? BeerModel(dictionary: dict) {
            return [mock]
        }
        
        return []
    }
    
    static func getBeerResponseMock() -> [AnyHashable: Any] {
        return [
            "id": 1,
            "name": "Buzz",
            "tagline": "A Real Bitter Experience.",
            "first_brewed": "09/2007",
            "description": "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
            "image_url": "https://images.punkapi.com/v2/keg.png",
            "abv": 4.5,
            "ibu": 60,
            "target_fg": 1010,
            "target_og": 1044,
            "ebc": 20,
        ]
    }
    
    
}
