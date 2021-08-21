//
//  ViewController.swift
//  2048
//
//  Created by Mitesh Soni on 21/08/21.
//

import UIKit

class ViewController: UIViewController {

    private var grid: [[Int?]] = Array(repeating: Array(repeating: nil, count: 4), count: 4)
    private var collectionView: UICollectionView! //= UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _init()
    }

    private func _init() {
        initCollectionView()
        initGestureRecognizer()
        tempButton()
    }
    
    private func initCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .cyan
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: "reuse")
        collectionView.reloadData()
        collectionView.reloadInputViews()
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
        case .up: upShift()
        case .down: downShift()
        case .right: rightShift()
        case .left: leftShift()
        default: print("default")
        }
    }
    
    private func tempButton() {
        let tempButton = UIButton(frame: .init(x: 50, y: 500, width: 100, height: 50))
        view.addSubview(tempButton)
        tempButton.setTitle("Seed", for: .normal)
        tempButton.backgroundColor = .gray
        tempButton.addTarget(self, action: #selector(onTempTap), for: .touchUpInside)
    }

    @objc private func onTempTap() {
        addRandomBitToGrid()
    }
    
    private func addRandomBitToGrid() {
        let randomRow = Int(arc4random_uniform(4))
        let randomColum = Int(arc4random_uniform(4))
//        grid = grid.map { $0.map { _ in nil }}
        grid[randomRow][randomColum] = arc4random_uniform(3) > 1 ? 2 : 4
        collectionView.reloadData()
    }
    
//    private func transform(_ arrayCoordinate: (x: Int, y: Int)) -> (x: Int, y: Int) {
//        return
//    }
    
    private func upShift() {
        print("up shift")
//        grid = grid.map { $0.map { $0.map { $0 * 4 }}}
        rotateSingleUp()
    }
    
    private func downShift() {
        print("down shift")
        rotateSingleDown()
    }
    
    private func leftShift() {
        print("left shift")
        grid = grid.map { rotateSingleLeft($0) }
        collectionView.reloadData()
    }
    
    private func rightShift() {
        print("right shift")
        grid = grid.map { rotateSingleRight($0) }
        collectionView.reloadData()
    }
    
    private func rotateSingleLeft(_ array : [Int?]) -> [Int?]{
        let first = array[0]
        var array = array
        for i in 0..<array.count - 1 {
            array[i] = array[i + 1]
        }
        array[array.count - 1] = first
        return array
    }
    
    func rotateSingleRight(_ array : [Int?]) -> [Int?] {
        let last = array[array.count - 1]
        var array = array
        for i in (1..<array.count).reversed() {
            array[i] = array[i - 1]
        }
        array[0] = last
        return array
    }
    
    func rotateSingleUp() {
        for i in 0..<grid[0].count {
            var temp = [ grid[0][i], grid[1][i], grid[2][i], grid[3][i] ]
            temp = rotateSingleLeft(temp)
            grid[0][i] = temp[0]
            grid[1][i] = temp[1]
            grid[2][i] = temp[2]
            grid[3][i] = temp[3]
        }
        
        collectionView.reloadData()
    }
    
    func rotateSingleDown() {
        for i in 0..<grid[0].count {
            var temp = [ grid[0][i], grid[1][i], grid[2][i], grid[3][i] ]
            temp = rotateSingleRight(temp)
            grid[0][i] = temp[0]
            grid[1][i] = temp[1]
            grid[2][i] = temp[2]
            grid[3][i] = temp[3]
        }
        
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        grid[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        grid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuse", for: indexPath) as! GridCell
        cell.backgroundColor = .brown
        let number = grid[indexPath.section][indexPath.row]
        cell.set(number: number)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / CGFloat(grid.count) - 10
        let height = width
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 2, left: 2, bottom: 2, right: 2)
    }
}
