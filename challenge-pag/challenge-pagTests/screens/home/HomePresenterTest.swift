//
//  HomePresenterTest.swift
//  challenge-pagTests
//
//  Created by Leonardo Sugano on 10/03/21.
//

@testable import challenge_pag
import Quick
import Nimble
import UIKit

class HomePresenterTest: QuickSpec {
    
    var sut: HomePresenter?
    var mockView: MockHomeView?
    var mockInteractor: MockHomeInteractor?
    var mockRouter: MockHomeRouter?
    
    override func spec() {
        describe("Home Presenter") {
            beforeEach {
                self.sut = HomePresenter()
                self.mockView = MockHomeView()
                self.mockInteractor = MockHomeInteractor()
                self.mockRouter = MockHomeRouter()
                
                self.mockInteractor?.output = self.sut
                self.sut?.view = self.mockView
                self.sut?.interactor = self.mockInteractor
                self.sut?.router = self.mockRouter
            }
            
            afterEach {
                self.sut = nil
                self.mockView = nil
                self.mockInteractor = nil
                self.mockRouter = nil
            }
            
            it("should test aux methods") {
                self.sut?.page = 1
                self.sut?.fetchBeers(pagination: true, refresh: false)
                expect(self.sut?.page).to(equal(2))
                
                self.sut?.fetchBeers(pagination: false, refresh: true)
                expect(self.sut?.page).to(equal(1))
            }
            
            it("should test pagination if add response") {
                self.sut?.fetchBeers(pagination: false, refresh: true)
                expect(self.sut?.beersResponse?.count).to(equal(1))
                
                self.sut?.fetchBeers(pagination: true, refresh: false)
                expect(self.sut?.beersResponse?.count).to(equal(2))
            }
            
            it("should test reset when has pagination and refresh") {
                self.sut?.fetchBeers(pagination: false, refresh: true)
                expect(self.sut?.beersResponse?.count).to(equal(1))
                
                self.sut?.fetchBeers(pagination: true, refresh: false)
                expect(self.sut?.beersResponse?.count).to(equal(2))

                self.sut?.fetchBeers(pagination: false, refresh: true)
                expect(self.sut?.beersResponse?.count).to(equal(1))
            }
            
            it("should test call error message") {
                self.mockInteractor?.fail = true
                self.sut?.fetchBeers(pagination: false, refresh: true)
                expect(self.mockRouter?.showAlert).to(beTrue())
                expect(self.mockRouter?.message).to(equal("error"))
            }
            
            it("should test called home protocols") {
                self.sut?.fetchBeers(pagination: false, refresh: false)
                expect(self.mockView?.showLoaderCalled).to(beTrue())
                expect(self.mockView?.endLoaderCalled).to(beTrue())
                expect(self.mockView?.showBeersCalled).to(beTrue())
            }
            
            it("should test not call success method in home protocols if error in API") {
                self.mockInteractor?.fail = true
                self.sut?.fetchBeers(pagination: false, refresh: true)
                expect(self.mockView?.showBeersCalled).to(beFalse())
            }
            
            it("should test call next navigation") {
                let nav = UINavigationController()
                let indexPath = IndexPath(row: 0, section: 0)
                
                self.sut?.fetchBeers(pagination: false, refresh: false)
                self.sut?.showDetailController(navigationController: nav, indexPath: indexPath)
                expect(self.mockRouter?.nav).to(equal(nav))
                expect(self.mockRouter?.beer).to(equal(MockResponse.getBeerDictionaryMock().first))
            }
        }
    }

}

class MockHomeView: PresenterToViewHomeProtocol {
    var showBeersCalled: Bool = false
    var showLoaderCalled: Bool = false
    var endLoaderCalled: Bool = false
    
    func showBeers() {
        self.showBeersCalled = true
    }
    
    func showLoader() {
        self.showLoaderCalled = true
    }
    
    func endLoader() {
        self.endLoaderCalled = true
    }
}

class MockHomeInteractor: HomeInteractor {
    var fail: Bool = false
    var output: InteractorToPresenterHomeProtocol?
    
    override func fetchBeers(page: Int, pagination: Bool) {
        if fail {
            output?.beersFetchFailed(message: "error")
        } else {
            output?.beersFetchedSuccess(response: MockResponse.getBeerDictionaryMock(), pagination: pagination)
        }
    }
}

class MockHomeRouter: HomeRouter {
    var nav: UINavigationController?
    var beer: BeerModel?
    var message: String?
    var showAlert = false
    
    override func pushToDetailScreen(navigationController: UINavigationController, beer: BeerModel) {
        self.beer = beer
        self.nav = navigationController
    }
    
    override func showAlert(message: String) {
        self.showAlert = true
        self.message = message
    }
}

