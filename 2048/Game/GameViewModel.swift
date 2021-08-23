//
//  GameViewModel.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

import Foundation

enum Direction {
    case up
    case down
    case left
    case right
}

class GameViewModel: BaseViewModel<GamePresenting> {
    
    // MARK: - Variables and constants
    
    private var grid: [[Int?]] = Array(repeating: Array(repeating: nil, count: 4), count: 4)
    private var score = 0
    private var leftRotationCount = 0
    private var rightRotationCount = 0
    private var leftRotationShouldMergeNumbers = true
    private var rightRotationShouldMergeNumbers = true
    
    override init(presenter: GamePresenting) {
        super.init(presenter: presenter)
        seed()
    }
    
    // MARK: - Business Logic
    
    func move(_ direction: Direction) {
        switch direction {
        case .up: upShift()
        case .down: downShift()
        case .left: leftShift()
        case .right: rightShift()
        }
        presenter.update(grid: grid)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.seed()
        }
    }
    
    private func seed() {
        let unoccupiedCells = getUnoccupiedCellsInGrid()
        guard unoccupiedCells.count > 0 else {
            showGameOverAlert()
            return
        }
        let randomUnOccupiedCellsLocation = arc4random_uniform(UInt32(unoccupiedCells.count))
        let seedLocation = unoccupiedCells[Int(randomUnOccupiedCellsLocation)]
        grid[seedLocation.x][seedLocation.y] = arc4random_uniform(3) > 1 ? 2 : 4
        presenter.update(grid: grid)
    }
    
    private func getUnoccupiedCellsInGrid() -> [(x: Int, y: Int)] {
        var unoccupiedCells: [(x: Int, y: Int)] = []
        for i in 0..<grid.count {
            for j in 0..<grid[i].count {
                if grid[i][j] == nil {
                    unoccupiedCells.append((x: i, y: j))
                }
            }
        }
        return unoccupiedCells
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
    }

    private func leftShift() {
        grid = grid.map { squashArrayLeft($0) }
    }
    
    private func rightShift() {
        grid = grid.map { squashArrayRight($0) }
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
                updateScore(array[i - 1] ?? 0)
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
                updateScore(array[i] ?? 0)
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
    
    func setUser(_ userName: String) {
        let attributedWelcomeMessage = getAttributedNameValuePair(fromName: StringsProvider.ViewControllers.Game.welcome, value: userName)
        presenter.present(welcomeMessage: attributedWelcomeMessage)
        updateScore(0)
    }
    
    func updateScore(_ score: Int) {
        self.score += score
        let scoreAttributedString = getAttributedNameValuePair(fromName: StringsProvider.ViewControllers.Game.score, value: String(self.score))
        presenter.update(score: scoreAttributedString)
    }
    
    private func getAttributedNameValuePair(fromName name: String, value: String) -> NSAttributedString {
        let nameAttributedString = NSMutableAttributedString(string: "\(name): ")
        let valueAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.primaryText.withAlphaComponent(0.8),
            .font: FontsProvider.shared.getFont(.clearSans(weight: .bold), size: 30)
        ]
        let valueAttributedString = NSAttributedString(string: value, attributes: valueAttributes)
        nameAttributedString.append(valueAttributedString)
        return nameAttributedString
    }
    
    func reset() {
        grid = grid.map { $0.map { _ in nil }}
        score = 0
        let scoreAttributedString = getAttributedNameValuePair(fromName: StringsProvider.ViewControllers.Game.score, value: "0")
        presenter.update(grid: grid)
        presenter.update(score: scoreAttributedString)
    }
    
    private func showGameOverAlert() {
        presenter.presentAlert(
            withTitle: StringsProvider.ViewControllers.Game.gameOverTitle,
            message: StringsProvider.ViewControllers.Game.gameOverMessage
        )
    }
    
    private func showVictoryAlert() {
        presenter.presentAlert(
            withTitle: StringsProvider.ViewControllers.Game.gameCompletionTitle,
            message: StringsProvider.ViewControllers.Game.gameCompleteMessage(withScore: score)
        )
    }
}


