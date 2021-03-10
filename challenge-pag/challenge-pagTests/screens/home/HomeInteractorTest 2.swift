//
//  HomeInteractor.swift
//  challenge-pagTests
//
//  Created by Leonardo Sugano on 10/03/21.
//

@testable import challenge_pag
import Quick
import Nimble
import UIKit
import AFNetworking

class HomeInteractorTest: QuickSpec {
    
    var sut: HomeInteractor?
    var presenter: MockInteractorToPresenterHomeProtocol?
    
    override func spec() {
        describe("Home Interactor") {
            beforeEach {
                self.sut = HomeInteractor()
                self.presenter = MockInteractorToPresenterHomeProtocol()
                self.sut?.presenter = self.presenter
                self.sut?.manager = AFHTTPSessionManager()
            }
            
            afterEach {
                self.sut = nil
                self.presenter = nil
            }
            
            it("should test error API") {
                self.sut?.fetchBeers(page: 0, pagination: false)
                expect(self.presenter?.error).toEventually(beTrue(), timeout: .seconds(5))

            }
            
            it("should test success API") {
                self.sut?.fetchBeers(page: 1, pagination: false)
                expect(self.presenter?.success).toEventually(beTrue(), timeout: .seconds(5))
            }
        }
    }
}

class MockInteractorToPresenterHomeProtocol: InteractorToPresenterHomeProtocol {
    var success: Bool = false
    var error: Bool = false
    
    func beersFetchedSuccess(response: [BeerModel], pagination: Bool) {
        self.success = true
    }
    
    func beersFetchFailed(message: String) {
        self.error = true
    }
}
