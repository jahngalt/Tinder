//
//  ViewController.swift
//  Tinder
//
//  Created by Oleg Kudimov on 11/26/20.
//

import UIKit

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonsStackView = HomeControllsStackView()
    let users = [
        User(name: "Kelly", age: 23, profession: "Barista", imageName: "lady5c"),
        User(name: "Molly", age: 30, profession: "Stripper", imageName: "lady4c")
    ]
    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Kelly", age: 23, profession: "Barista", imageName: "lady5c"),
            User(name: "Molly", age: 30, profession: "Stripper", imageName: "lady4c"),
            Advertiser(title: "your advertise is here", brandName: "google", posterPhotoName: "1")
        ] as [ProducesCardViewModel]
        
        let viewModels = producers.map(({return $0.toCardViewModel()}))
        return viewModels
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDummyCards()
    }
    
    
    // MARK:- Fileprivate
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardViewModel) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardViewModel  
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        
    }
    
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
}

