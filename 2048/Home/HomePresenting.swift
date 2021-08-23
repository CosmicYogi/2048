//
//  HomePresenter.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

protocol HomePresenting {
    func startGameForUser(_ userName: String)
    func showError(_ error: Error)
}
