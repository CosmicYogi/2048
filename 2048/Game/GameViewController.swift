//
//  GameViewController.swift
//  2048
//
//  Created by Mitesh Soni on 22/08/21.
//

import UIKit

class GameViewController: UIViewController, AlertDisplaying {

    // MARK: - Outlets
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables and constants
    private let reusableIdentifier = "game_cell"
    private var userName: String!
    private var viewModel: GameViewModel!
    private var grid: [[Int?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _init()
    }
    
    private func _init() {
        initViews()
        initCollectionView()
        initGestureRecognizer()
        initViewModel()
    }
    
    private func initViews() {
        newGameButton.setTitle(StringsProvider.ViewControllers.Game.newGame, for: .normal)
        newGameButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
    }
    
    private func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = false
    }
    
    private func initViewModel() {
        viewModel = GameViewModel(presenter: self)
        viewModel.setUser(userName)
    }
    
    private func initGestureRecognizer() {
        let gestureRecognizerUp = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture))
        let gestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture))
        let gestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture))
        let gestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture))
        gestureRecognizerUp.direction = .up
        gestureRecognizerDown.direction = .down
        gestureRecognizerRight.direction = .right
        gestureRecognizerRight.direction = .left

        view.addGestureRecognizer(gestureRecognizerUp)
        view.addGestureRecognizer(gestureRecognizerDown)
        view.addGestureRecognizer(gestureRecognizerLeft)
        view.addGestureRecognizer(gestureRecognizerRight)
    }
    
    @objc private func onSwipeGesture(gesture: UIGestureRecognizer) {
        guard let gesture = gesture as? UISwipeGestureRecognizer else { return }
        switch gesture.direction {
        case .up: viewModel.move(.up)
        case .down: viewModel.move(.down)
        case .right: viewModel.move(.right)
        case .left: viewModel.move(.left)
        default: break
        }
    }
    
    @objc private func reset() {
        viewModel.reset()
    }
    
    // MARK: - Outside communication
    
    func setUser(_ userName: String) {
        self.userName = userName
    }
}

//MARK: - CollectionView delegate, datasource
extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        grid[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        grid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! GameCell
        let number = grid[indexPath.section][indexPath.row]
        cell.set(number: number)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / CGFloat(grid.count) - 8
        let height = collectionView.bounds.width / CGFloat(grid.count)
        return CGSize(width: width, height: height)
    }
}

//MARK: - GamePresenting
extension GameViewController: GamePresenting {
    
    func present(welcomeMessage: NSAttributedString) {
        welcomeLabel.attributedText = welcomeMessage
    }
    
    func update(grid: [[Int?]]) {
        print(grid)
        self.grid = grid
        collectionView.reloadData()
    }

    func update(score: NSAttributedString) {
        scoreLabel.attributedText = score
    }
    
    func presentAlert(withTitle title: String, message: String) {
        showAlert(withTitle: title, message: message, actionText: StringsProvider.ok) { [weak self] in
            self?.viewModel.reset()
        }
    }
    
    func presentGameCompletedAlert(withTitle title: String, message: String) {
        showAlert(withTitle: title, message: message, actionText: StringsProvider.ok) {
        }
    }
    
    func setUserInteractionEnabled(_ enabled: Bool) {
        guard let gestureRecognizers = view.gestureRecognizers else { return }
        for gesture in gestureRecognizers {
            gesture.isEnabled = enabled
        }
    }
}
