//
//  DetailViewController.swift
//  challenge-pagTests
//
//  Created by Leonardo Sugano on 10/03/21.
//

@testable import challenge_pag
import Quick
import Nimble
import UIKit

class DetailViewControllerTest: QuickSpec {

    var sut: DetailViewController?
    var router: DetailRouter?
    
    override func spec() {
        describe("DetailViewController") {
            beforeEach {
                self.sut = DetailRouter.createModule()
                self.sut?.beginAppearanceTransition(true, animated: true)
                self.sut?.endAppearanceTransition()
                self.sut?.viewDidLoad()
            }
            
            afterEach {
                self.sut = nil
            }
            
            it("should test sut not nil") {
                expect(self.sut).toNot(beNil())
            }
            
            it("should test instaciate view") {
                self.sut?.showDetailBeer(beer: MockResponse.getBeerDictionaryMock().first!)
                expect(self.sut?.beerNameLabel?.text).to(equal("Buzz"))
                expect(self.sut?.taglineLabel?.text).to(equal("A Real Bitter Experience."))
                expect(self.sut?.alcoholContentLabel?.text).to(equal("Teor alcoólico: 4.5%"))
                expect(self.sut?.bitternessScaleLabel?.text).to(equal("Escala de amargor: 60"))
                expect(self.sut?.descriptionLabel?.text).to(equal("A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once."))
            }
        }
    }
}
