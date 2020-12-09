//
//  CardViewModel.swift
//  Tinder
//
//  Created by Oleg Kudimov on 12/6/20.
//

import UIKit


protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    //here we have properthies that our view will display/render
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    
}
