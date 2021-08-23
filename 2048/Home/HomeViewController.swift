//
//  HomeViewController.swift
//  2048
//
//  Created by Mitesh Soni on 22/08/21.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var bottomPadding: NSLayoutConstraint!
    
    
    // MARK: - Variables and Constants
    
    private var viewModel: HomeViewModel!
    
    
    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _init()
    }
    
    
    // MARK: - Initial setup
    
    private func _init() {
        initViews()
        initViewModel()
    }
    
    private func initViews() {
        let startButtonTitle = StringsProvider.ViewControllers.Home.startButton
        userNameTextField.placeholder = StringsProvider.ViewControllers.Home.userNameFieldPlaceHolder
        userNameTextField.delegate = self
        startButton.setTitle(startButtonTitle, for: .normal)
        startButton.addTarget(self, action: #selector(onStartButtonTap), for: .touchUpInside)
    }
    
    private func initViewModel() {
        viewModel = HomeViewModel(presenter: self)
    }
    
    // MARK: - Keyboard management
    
    override func keyboardWillShow(notification: NSNotification) {
        view.animateWithKeyboard(notification: notification, constraint: bottomPadding, constant: 0)
    }
    
    override func keyboardWillHide(notification: NSNotification) {
        view.animateWithKeyboard(notification: notification, constraint: bottomPadding, constant: 0)
    }
    
    @objc private func onStartButtonTap() {
        viewModel.startGameForUser(userNameTextField.text)
    }
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let _ = textField.text else { return false }
        onStartButtonTap()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let userName = textField.text else { return false }
        if userName.hasPrefix(StringsProvider.atTheRate) { textField.text = userName}
        else { textField.text = StringsProvider.atTheRate + userName }
        return true
    }
}

// MARK: - HomePresenting
extension HomeViewController: HomePresenting {
    func startGameForUser(_ userName: String) {
        push(.game, animated: true)
//        let viewController = ViewControllerDebugging()
//        viewController.modalPresentationStyle = .fullScreen
//        present(viewController, animated: true)
    }
    
    func showError(_ error: Error) {
        // TODO: - Show alert
    }
}
