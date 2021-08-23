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
            print("GameOver")
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
        
    }
    
    private func downShift() {
        
    }
    
    private func leftShift() {
        
    }
    
    private func rightShift() {
        
    }
}


