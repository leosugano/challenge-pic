//
//  HomeViewControllerTest.swift
//  challenge-pagTests
//
//  Created by Leonardo Sugano on 10/03/21.
//

@testable import challenge_pag
import Quick
import Nimble
import UIKit
import AFNetworking

class HomeRouterTest: QuickSpec {

    var sut: HomeViewController?
    var navigationController: UINavigationController?
    var router: HomeRouter?
    
    override func spec() {
        describe("HomeViewController") {
            beforeEach {
                self.sut = HomeRouter.createModule()
                self.navigationController = UINavigationController(rootViewController: self.sut!)
                self.navigationController?.beginAppearanceTransition(true, animated: true)
                self.navigationController?.endAppearanceTransition()
                self.router = HomeRouter()
                self.sut?.viewDidLoad()
            }
            
            afterEach {
                self.sut = nil
                self.navigationController = nil
                self.router = nil
            }
            
            it("should test to navigation to detail screen") {
                self.router?.pushToDetailScreen(navigationController: self.navigationController!, beer: MockResponse.getBeerDictionaryMock().first!)
                expect(self.navigationController?.viewControllers.last).toEventually(beAKindOf(DetailViewController.self), timeout: .seconds(5))
            }
            
            it("should test to show alert") {
                self.router?.showAlert(message: "teste de erro")
                
                let lastView = self.navigationController?.viewControllers.last?.presentedViewController
                if let alert = lastView as? UIAlertController {
                    expect(alert.message).to(equal("teste de erro"))
                }
            }
        }
    }
  
}
