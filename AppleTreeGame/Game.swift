//
//  Game.swift
//  AppleTreeGame
//
//  Created by Mahima Borah on 23/09/18.
//  Copyright © 2018 Mahima Borah. All rights reserved.
//

import Foundation

struct Game{
    var word : String
    var incorrectMovesRemaining : Int
    var guessedLetters : [String]
    
    mutating func playerGuessed(letter: String){
        guessedLetters.append(letter)
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
        }
    }
    
    var formatterWord : String {
        var guessedWord = ""
        for letter in word{
            if guessedLetters.contains(String(letter)){
                guessedWord += "\(letter)"
            }else{
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
