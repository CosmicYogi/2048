//
//  ViewController.swift
//  2048
//
//  Created by Mitesh Soni on 21/08/21.
//

import UIKit

class ViewControllerDebugging: UIViewController {

    private var grid: [[Int?]] = Array(repeating: Array(repeating: nil, count: 4), count: 4)
    private var collectionView: UICollectionView! //= UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    private var leftRotationCount = 0
    private var rightRotationCount = 0
    private var leftRotationShouldMergeNumbers = true
    private var rightRotationShouldMergeNumbers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _init()
    }

    private func _init() {
        initCollectionView()
        initGestureRecognizer()
        initSeedButton()
        initClearButton()
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
        default: break
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.seed()
        }
    }

    private func initSeedButton() {
        let seedButton = UIButton(frame: .init(x: 50, y: 500, width: 100, height: 50))
        view.addSubview(seedButton)
        seedButton.setTitle("Seed", for: .normal)
        seedButton.backgroundColor = .gray
        seedButton.addTarget(self, action: #selector(seed), for: .touchUpInside)
    }

    @objc private func seed() {
        addRandomBitToGrid()
    }

    private func initClearButton() {
        let clearButton = UIButton(frame: .init(x: 180, y: 500, width: 100, height: 50))
        view.addSubview(clearButton)
        clearButton.setTitle("Clear", for: .normal)
        clearButton.backgroundColor = .gray
        clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
    }

    @objc private func clear() {
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                grid[i][j] = nil
            }
        }
        collectionView.reloadData()
    }

    private func addRandomBitToGrid() {
        let randomRow = Int(arc4random_uniform(4))
        let randomColum = Int(arc4random_uniform(4))
//        grid = grid.map { $0.map { _ in nil }}
        var unoccupiedCells: [(x: Int, y: Int)] = [
        ]

        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                if grid[i][j] == nil {
                    unoccupiedCells.append((x: i, y: j))
                }
            }
        }
        print("unoccupied cells are")
        guard unoccupiedCells.count > 0 else {
            print("GameOver")
            return
        }
        let randomUnOccupiedCellsLocation = arc4random_uniform(UInt32(unoccupiedCells.count))
        let seedLocation = unoccupiedCells[Int(randomUnOccupiedCellsLocation)]

        grid[seedLocation.x][seedLocation.y] = arc4random_uniform(3) > 1 ? 2 : 4
        collectionView.reloadData()

        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                if grid[i][j] == nil {
                    unoccupiedCells.append((x: i, y: j))
                }
            }
        }
    }

    private func upShift() {
        for i in 0..<grid[0].count {
            var temp = [ grid[0][i], grid[1][i], grid[2][i], grid[3][i] ]
            temp = squashArrayLeft(temp)
            grid[0][i] = temp[0]
            grid[1][i] = temp[1]
            grid[2][i] = temp[2]
            grid[3][i] = temp[3]
        }

        collectionView.reloadData()
    }

    private func downShift() {
        for i in 0..<grid[0].count {
            var temp = [ grid[0][i], grid[1][i], grid[2][i], grid[3][i] ]
            temp = squashArrayRight(temp)
            grid[0][i] = temp[0]
            grid[1][i] = temp[1]
            grid[2][i] = temp[2]
            grid[3][i] = temp[3]
        }

        collectionView.reloadData()
    }

    private func leftShift() {
        grid = grid.map { squashArrayLeft($0) }
        collectionView.reloadData()
    }

    private func rightShift() {
        grid = grid.map { squashArrayRight($0) }
        collectionView.reloadData()
    }

    
    private func squashArrayLeft(_ array : [Int?]) -> [Int?]{
        var array = array
        for i in (1...array.count).reversed() {
            if array[i - 1] == nil && i < array.count{
                array[i - 1] = array[i]
                array[i] = nil
            }
        }
        for var i in (1...array.count - 1).reversed() {
            if let value = array[i - 1], let nextValue = array[i], value == nextValue, leftRotationShouldMergeNumbers {
                array[i - 1] = value * 2
                array[i] = nil
                i -= 1
                leftRotationShouldMergeNumbers = false
                break
            }
        }
        if leftRotationCount < array.count {
            leftRotationCount += 1
            array = squashArrayLeft(array)
        } else {
            leftRotationCount = 0
            leftRotationShouldMergeNumbers = true
        }
        return array
    }

    func squashArrayRight(_ array : [Int?]) -> [Int?] {
        var array = array
        for i in (1...array.count - 1) {
            if array[i] == nil {
                array[i] = array[i - 1]
                array[i - 1] = nil
            }

        }
        for var i in (1...array.count - 1) {
            if let value = array[i], let previousValue = array[i - 1], value == previousValue, rightRotationShouldMergeNumbers {
                array[i] = value * 2
                array[i - 1] = nil
                i += 1
                rightRotationShouldMergeNumbers = false
                break
            }
        }
        if rightRotationCount < array.count {
            rightRotationCount += 1
            array = squashArrayRight(array)
        } else {
            rightRotationCount = 0
            rightRotationShouldMergeNumbers = true
        }
        return array
    }
}

extension ViewControllerDebugging: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 2, left: 2, bottom: 2, right: 2)
    }
}
