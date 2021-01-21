//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by Oleg Kudimov on 1/18/21.
//

import UIKit

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    
    var fullName: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() }}
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false  && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
//        isFormValidObserver?(isFormValid)
    }
    
    //reactive
    var isFormValidObserver: ((Bool) -> ())?
    var bindableIsFormValid = Bindable<Bool>()
}
