//
//  DetaIlPresenterTest.swift
//  challenge-pagTests
//
//  Created by Leonardo Sugano on 10/03/21.
//
@testable import challenge_pag
import Quick
import Nimble
import UIKit

class DetailPresenterTest: QuickSpec {
    
    var sut: DetailPresenter?
    var mockView: MockDetailView?
    
    override func spec() {
        describe("Detail Presenter") {
            beforeEach {
                self.sut = DetailPresenter()
                self.mockView = MockDetailView()
                self.sut?.view = self.mockView
                self.sut?.beersResponse = MockResponse.getBeerDictionaryMock().first
            }
            
            afterEach {
                self.sut = nil
                self.mockView = nil
            }
            
            it("should test call showDetail and pass beer") {
                self.sut?.showDetailBeer()
                expect(self.mockView?.showDetailBeerCalled).to(beTrue())
                expect(self.mockView?.beer).to(equal(MockResponse.getBeerDictionaryMock().first))
            }
            
            it("should test not call showDetail if beer is nil") {
                self.sut?.beersResponse = nil
                self.sut?.showDetailBeer()
                expect(self.mockView?.showDetailBeerCalled).to(beFalse())
            }
        }
    }
}

class MockDetailView: PresenterToViewDetailProtocol {
    var showDetailBeerCalled: Bool = false
    var beer: BeerModel?
    
    func showDetailBeer(beer: BeerModel) {
        self.showDetailBeerCalled = true
        self.beer = beer
    }
}
