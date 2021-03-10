//
//  RoundedImageViewTest.swift
//  challenge-pagTests
//
//  Created by Leonardo Sugano on 10/03/21.
//

@testable import challenge_pag
import Quick
import Nimble
import UIKit

class RoundedImageViewTest: QuickSpec {
    
    override func spec() {
        describe("RoundedImageView") {
            it("should return rounded corners in imageView") {
                let imageView = RoundedImageView()
                imageView.clipsToBounds = false
                imageView.cornerRadius = 10
                
                expect(imageView.layer.cornerRadius).to(equal(10))
                expect(imageView.clipsToBounds).to(beTrue())
            }
        }
    }
}
