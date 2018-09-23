//
//  ViewController.swift
//  AppleTreeGame
//
//  Created by Mahima Borah on 23/09/18.
//  Copyright © 2018 Mahima Borah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTreeImage: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letters: [UIButton]!
    @IBOutlet weak var hints: UILabel!
    
    var wordList = ["applepie", "walnutcake", "honeydew", "cheesecake", "strawberryshortcake"]
    var hintList = ["Related to the name of the game", "Nutty and cakey", "Sweet and made from buzzy creatures", "Join a savoury and sweet item", "The name of one of our fav TV cartoons"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    var totalLoses = 0 {
        didSet{
            newRound()
        }
    }
    
    private var currentGame : Game!
    
    func newRound(){
        if !wordList.isEmpty{
            let newWord = wordList.removeFirst()
            let hint = hintList.removeFirst()
            hints.text = hint
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }else{
            scoreLabel.text = "Final score: \(totalWins)"
            enableLetterButtons(false)
        }
    }
    
    private func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0 {
            totalLoses += 1
        }else if currentGame.word == currentGame.formatterWord{
            totalWins += 1
        }else{
            correctWordLabel.sizeToFit()
            scoreLabel.sizeToFit()
            updateUI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func enableLetterButtons(_ enable: Bool){
        //This function enables all the letter buttons at the beginning of a new round (word)
        for button in letters{
            button.isEnabled = enable
        }
    }
    
    func updateUI(){
        correctWordLabel.sizeToFit()
        scoreLabel.sizeToFit()
        var letters = [String]()
        for letter in currentGame.formatterWord{
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        correctWordLabel.sizeToFit()
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLoses)"
        scoreLabel.sizeToFit()
        myTreeImage.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    @IBAction private func buttonTapped(_ sender: UIButton){
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = letterString.lowercased()
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }


}

