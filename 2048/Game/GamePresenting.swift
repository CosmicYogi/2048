//
//  GamePresenting.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

protocol GamePresenting {
    func present(userName: String)
    func update(grid: [[Int?]])
    func update(score: Int)
}
