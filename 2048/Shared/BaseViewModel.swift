//
//  BaseViewModel.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

class BaseViewModel<T> {
    let presenter: T
    
    init(presenter: T) {
        self.presenter = presenter
    }
}

