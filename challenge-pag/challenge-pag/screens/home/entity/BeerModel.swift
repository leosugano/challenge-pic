//
//  BeerModel.swift
//  challenge-pag
//
//  Created by Leonardo Sugano on 08/03/21.
//

import Foundation
import Mantle


class BeerModel: MTLModel, MTLJSONSerializing {
    @objc var imageBeer: String?
    @objc var descriptionBeer: String?
    @objc var alcoholContent: NSNumber?
    @objc var tagline: String?
    @objc var bitternessScale: NSNumber?
    @objc var name: String?
    
    static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [
                "imageBeer" : "image_url",
                "descriptionBeer" : "description",
                "alcoholContent" : "abv",
                "tagline": "tagline",
                "bitternessScale": "ibu",
                "name" : "name",
              ]
    }
}
