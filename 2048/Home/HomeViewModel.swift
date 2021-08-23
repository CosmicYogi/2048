//
//  HomeViewModel.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

class HomeViewModel: BaseViewModel<HomePresenting> {
    
    // MARK: - Business Logic
    
    func startGameForUser(_ userName: String?) {
        // In real world schenario do an api call to register user.
        // Handle success/failure and call presenter
        if let userName = userName, !userName.isEmpty {
            presenter.startGameForUser(userName)
            return
        }
        presenter.showError(ErrorsProvider.invalidUser)
    }
}

