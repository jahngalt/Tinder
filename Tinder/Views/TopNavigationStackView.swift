//
//  TopNavigationStackView.swift
//  Tinder
//
//  Created by Oleg Kudimov on 11/28/20.
//

import UIKit

class TopNavigationStackView: UIStackView {
    
    let settingsButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let fireImageView = UIImageView(image: #imageLiteral(resourceName: "3 7"))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        fireImageView.contentMode = .scaleAspectFit
        
        settingsButton.setImage(#imageLiteral(resourceName: "3 6").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "3 8").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [settingsButton, UIView(),  fireImageView, UIView(),  messageButton].forEach { (v) in
            addArrangedSubview(v)
        }
        
        distribution = .equalCentering
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
