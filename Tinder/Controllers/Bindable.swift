//
//  Bindable.swift
//  Tinder
//
//  Created by Oleg Kudimov on 1/21/21.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    
    var observer: ((T?) ->())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
