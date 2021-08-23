//
//  StringsProvider.swift
//  2048
//
//  Created by Mitesh Soni on 23/08/21.
//

enum StringsProvider {
    enum ViewControllers {
        enum Home {
            static let title = "2048"
            static let userNameFieldPlaceHolder = "@user_name"
            static let startButton = "START"
        }
        enum Game {
            static let score = "Score"
            static let welcome = "Welcome"
            static let newGame = "New Game"
            static let gameOverTitle = "Game Over"
            static let gameOverMessage = "Sorry, Game Over. Play again?"
            static let gameCompletionTitle = "You Won!"
            static func gameCompleteMessage(withScore scote: Int) -> String {
                return "Congratulations!, You had won the game with the score of \(score)"
            }
        }
    }
    
    static let ok = "OK"
    static let cancel = "Cancel"
    static let atTheRate = "@"
}

