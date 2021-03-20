//
//  ViewController.swift
//  Tinder
//
//  Created by Oleg Kudimov on 11/26/20.
//

import UIKit
import Firebase
import JGProgressHUD

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let bottomControls = HomeControllsStackView()

    var lastFetchedUser: User?
    
    var cardViewModels = [CardViewModel]()
//    let cardViewModels: [CardViewModel] = {
//        let producers = [
//            User(name: "Kelly", age: 23, profession: "Barista", imageNames: ["kelly1", "kelly2", "kelly3"]),
//            User(name: "Jane", age: 30, profession: "Stripper", imageNames: ["jane1", "jane2", "jane3"]),
//            Advertiser(title: "your advertise is here", brandName: "google", posterPhotoName: "1")
//        ] as [ProducesCardViewModel]
//
//        let viewModels = producers.map(({return $0.toCardViewModel()}))
//        return viewModels
//    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        bottomControls.refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
        setupLayout()
        setupFirestoreUserCards()
        fetchUserFromFirestore()
    }
    
    
    @objc fileprivate func handleRefresh() {
        fetchUserFromFirestore()
    }
    
    //show settings controller page
    @objc fileprivate func handleSettings() {
        let settingsController = SettingsController()
        let navController = UINavigationController(rootViewController: settingsController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    
    // MARK:- Fileprivate
    fileprivate func setupFirestoreUserCards() {
        cardViewModels.forEach { (cardViewModel) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardViewModel  
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    
    fileprivate func fetchUserFromFirestore() {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Fetching users"
        hud.show(in: view)
        
        let query = Firestore.firestore().collection("users").order(by: "uid").start(after: [lastFetchedUser?.uid ?? ""]).limit(to:2)
        query.getDocuments { (snapshot, err) in
            hud.dismiss()
            if let err = err {
                print("Failed to fetch users: ", err)
                return
        }
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModels.append(user.toCardViewModel())
                self.lastFetchedUser = user
                self.setupCardFromUser(user: user)
            })
            //self.setupFirestoreUserCards()
        }
    }
    
    
    fileprivate func setupCardFromUser(user: User) {
        let cardView = CardView(frame: .zero)
        cardView.cardViewModel = user.toCardViewModel()
        cardsDeckView.addSubview(cardView)
        cardsDeckView.sendSubviewToBack(cardView)
        cardView.fillSuperview()
    }
    
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, bottomControls ])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
}

