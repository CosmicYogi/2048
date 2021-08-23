//
//  GameViewController.swift
//  2048
//
//  Created by Mitesh Soni on 22/08/21.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var collectionViewContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables and constants
    private var userName: String!
    private var viewModel: GameViewModel!
    private var grid: [[Int?]] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        _init()
    }
    
    private func _init() {
        initCollectionView()
        initGestureRecognizer()
        initViewModel()
    }
    
    private func initCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = false
    }
    
    private func initViewModel() {
        viewModel = GameViewModel(presenter: self)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "game_cell", for: indexPath) as! GameCell
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
    
    func present(userName: String) {
        welcomeLabel.text = "Welcome \(userName)"
    }
    
    func update(grid: [[Int?]]) {
        print(grid)
        self.grid = grid
        collectionView.reloadData()
    }

    func update(score: Int) {
        scoreLabel.text = "Score: \(score)"
    }
}
