//
//  ViewController.swift
//  BackgroundFetch
//
//  Created by Yusuf Turan on 17.09.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

  var player = AVAudioPlayer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    do {
      let filePath = Bundle.main.path(forResource: "music", ofType: ".mp3")
      player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: filePath!))
      player.prepareToPlay()
    } catch {
      print(error.localizedDescription)
    }
  }

  @IBAction func startMusic(_ sender: Any) {
    player.play()
  }
  
  @IBAction func stopMusic(_ sender: Any) {
    player.stop()
  }
}

