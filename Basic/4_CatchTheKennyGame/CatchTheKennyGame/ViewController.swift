//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Yusuf Turan on 11.06.2021.
//

import UIKit

class ViewController: UIViewController {
  var currScore = 0
  var highScore = 0
  var counter = 0
  var timer = Timer()
  var showKennyTimer = Timer()
  
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var highScoreLabel: UILabel!
  @IBOutlet var kennies: [UIImageView]!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    checkHighScore()
    hideKennies()
    startNewGame()
    
    scoreLabel.text = "Score: \(currScore)"
    var recognizers = Array(repeating: UITapGestureRecognizer(), count: kennies.count)
    
    for i in 0..<kennies.count {
      kennies[i].isUserInteractionEnabled = true
      recognizers[i] = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
      kennies[i].addGestureRecognizer(recognizers[i])
    }
    
  }
  
  func startNewGame() {
    self.currScore = 0
    self.counter = 10
    self.scoreLabel.text = "Score: \(self.currScore)"
    self.timeLabel.text = ("Remaining:  \(self.counter) sec.")
    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    self.showKennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(showRandomKenny), userInfo: nil, repeats: true)
  }
  
  func checkHighScore() {
    let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
    if storedHighScore == nil {
      highScore = 0
      highScoreLabel.text = "Highscore: \(highScore)"
    }
    if let newScore = storedHighScore as? Int {
      highScore = newScore
      highScoreLabel.text = "Highscore: \(highScore)"
    }
  }
  
  func hideKennies() {
    for kenny in kennies {
      kenny.isHidden = true
    }
  }
  
  @objc func showRandomKenny() {
    hideKennies()
    let random = Int(arc4random_uniform(UInt32(kennies.count - 1)))
    kennies[random].isHidden = false
  }
  
  @objc func increaseScore() {
    currScore += 1
    scoreLabel.text = "Score: \(currScore)"
  }
  
  @objc func countDown() {
    counter -= 1
    timeLabel.text = ("Remaining:  \(counter) sec.")
    
    if counter == 0 {
      timer.invalidate()
      showKennyTimer.invalidate()
      hideKennies()
      if self.currScore > self.highScore {
        self.highScore = self.currScore
        highScoreLabel.text = "Highscore: \(self.highScore)"
        UserDefaults.standard.set(self.highScore, forKey: "highscore")
      }
      let alert = UIAlertController(title: "Time's Up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
      let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
      let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
        self.startNewGame()
      }
      alert.addAction(okButton)
      alert.addAction(replayButton)
      self.present(alert, animated: true, completion: nil)
    }
  }
}

