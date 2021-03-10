//
//  LoaderTest.swift
//  challenge-pagTests
//
//  Created by Leonardo Sugano on 10/03/21.
//

@testable import challenge_pag
import Quick
import Nimble
import UIKit

class LoaderTest: QuickSpec {
    
    override func spec() {
        describe("Loader") {
            let view = UIView()
            
            it("should return loader at view") {
                view.showLoader()
                expect(view.subviews.last).to(beAKindOf(Loader.self))
            }
            
            it("should remove loader at view") {
                view.showLoader()
                view.removeLoader()
                expect(view.subviews.last).toEventually(beNil(), timeout: DispatchTimeInterval.milliseconds(3000))
            }
            
            it("should be nil init with nscoder") {
                let loader = Loader(coder: NSCoder())
                expect(loader).to(beNil())
            }
            
            afterEach {
                view.removeLoader()
            }
            
        }
    }
    
}
