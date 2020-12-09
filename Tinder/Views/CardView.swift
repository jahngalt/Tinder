//
//  CardView.swift
//  Tinder
//
//  Created by Oleg Kudimov on 11/29/20.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            imageView.image = UIImage(named: cardViewModel.imageName)
            infoLabel.attributedText = cardViewModel.attributedString
            infoLabel.textAlignment = cardViewModel.textAlignment
        }
    }
    
    
    //encapsulation
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let infoLabel = UILabel()
    //configs
    fileprivate let threshold: CGFloat = 80
    let gradientLayer = CAGradientLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    
    fileprivate func setupGradientLayer() {
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    
    fileprivate func setupLayout() {
        layer.cornerRadius = 20
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        //add gradient layer
        setupGradientLayer()
        
        addSubview(infoLabel)
        infoLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        infoLabel.textColor = .white
        infoLabel.numberOfLines = 0
    }
    
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        //rotation
        let translation = gesture.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        //radians to angles
        let angle  = degrees * .pi / 180
        
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
            
        case .ended:
            handleEnded(gesture)
            
        default:
            ()
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            
            if shouldDismissCard {
                self.layer.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
                
            } else {
                self.transform = .identity
            }
        } completion: { (_) in
            self.transform = .identity
                if shouldDismissCard {
                    self.removeFromSuperview()
                }
            //self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
}
