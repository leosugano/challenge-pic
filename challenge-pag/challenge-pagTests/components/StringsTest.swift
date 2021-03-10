//
//  StringsTest.swift
//  challenge-pagTests
//
//  Created by Leonardo Sugano on 10/03/21.
//

@testable import challenge_pag
import Quick
import Nimble
import UIKit

class StringsTest: QuickSpec {
    
    override func spec() {
        describe("String") {            
            it("should return localized string") {
                expect("home_title".localized()).to(equal("PunkAPI Beers"))
            }
        }
    }
}
