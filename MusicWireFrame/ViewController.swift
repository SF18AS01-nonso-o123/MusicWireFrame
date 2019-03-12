//
//  ViewController.swift
//  MusicWireFrame
//
//  Created by Chinonso Obidike on 3/12/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var reverseBackground: UIView!
    @IBOutlet weak var pauseBackground: UIView!
    @IBOutlet weak var forwardBackground: UIView!
    
    var audioPlayer: AVAudioPlayer? = nil
    
    
    var isPlaying: Bool = true {
        didSet {
            if isPlaying {
                pauseButton.setImage(UIImage(named: "pause")!, for: .normal)
                audioPlayer?.play()
            } else {
                pauseButton.setImage(UIImage(named: "play")!, for: .normal)
                audioPlayer?.pause()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        [reverseBackground, pauseBackground, forwardBackground].forEach {
            $0!.layer.cornerRadius = 35
            $0!.clipsToBounds = true
            $0!.alpha = 0.0
        }
        
        guard let url: URL = Bundle.main.url(forResource: "musette", withExtension: "mp3") else {
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            return
        }
    }
    
        
        
    

    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        if isPlaying {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.albumImageView.transform = CGAffineTransform.identity
            })
        }
        
        isPlaying = !isPlaying
    }
    
    @IBAction func touchedUpInside(_ sender: UIButton) {
        var buttonBackground: UIView
        
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case pauseButton:
            buttonBackground = pauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            buttonBackground.alpha = 0.0
            buttonBackground.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            sender.transform = CGAffineTransform.identity
        }) {(_) in                            //completion closure
            buttonBackground.transform = CGAffineTransform.identity
        }
    }
    
   
    @IBAction func touchedDownInside(_ sender: UIButton) {
        let buttonBackground: UIView
        
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case pauseButton:
            buttonBackground = pauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            buttonBackground.alpha = 0.3
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
}

