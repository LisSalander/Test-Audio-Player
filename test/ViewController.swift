//
//  ViewController.swift
//  test
//
//  Created by vika on 7/10/17.
//  Copyright © 2017 vika. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer


class ViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var playOutlet: UIButton!
    @IBOutlet weak var prevOutlet: UIButton!
    @IBOutlet weak var nextOutlet: UIButton!
    var audioPlayer = AVAudioPlayer()
    let arraySound = ["shum_dozhdja","ptici_v_lesu","kvakane_ljagushki","zvuki-delfinov","rychanie-tigra","lesnoy-ruchey","koster","groza","belyy-shum-shum-morya","metel-i-sneg"]
    var indexSound = Int()
    var sound = String()
    let tableView = TableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    sound = arraySound[indexSound]
    self.soundFunc()
        detailImage.image = UIImage(named: tableView.arrayPicture[indexSound])
    self.detailImage.layer.cornerRadius = self.detailImage.frame.size.width/15
    self.detailImage.clipsToBounds = true
       
        
    let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(action(swipe:)))
    swipeRecognizer.direction = .right
    self.view.addGestureRecognizer(swipeRecognizer)
    }
    
    func soundFunc(){
        do{
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: sound, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            
            var audioSesion = AVAudioSession.sharedInstance()
            do{
                try audioSesion.setCategory(AVAudioSessionCategoryPlayback)
            }
            
        }
        catch{
            print("Error")
        }
    }
    func setUpBackgroundMode() {
        var artwork = MPMediaItemArtwork(image: UIImage(named: tableView.arrayPicture[indexSound])!)
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: tableView.arrayNameSound[indexSound],
            MPMediaItemPropertyPlaybackDuration: audioPlayer.duration,
            MPMediaItemPropertyArtwork: artwork
        ]
        UIApplication.shared.beginReceivingRemoteControlEvents()
        becomeFirstResponder()

    }

    override func remoteControlReceived(with event: UIEvent?) {
        if let receivedEvent = event {
            if (receivedEvent.type == .remoteControl) {
                switch receivedEvent.subtype {
                case .remoteControlTogglePlayPause:
                    actionPlaySong(audioPlayer.isPlaying)
                case .remoteControlPlay:
                    actionPlaySong(false)
                case .remoteControlPause:
                    actionPlaySong(true)
                case .remoteControlNextTrack:
                    self.nextSound()
                case .remoteControlPreviousTrack:
                    self.prevSound()
                default:
                    print("received sub type \(receivedEvent.subtype) Ignoring")
                }
            }
        }
    }
    
    var isPlaying: Bool = false {
        didSet {
            changeButtonImage(isPlaying)
        }
    }
    
    @IBAction func Play(_ sender: Any) {
        actionPlaySong(audioPlayer.isPlaying)

    }
    
   
    @IBAction func prev(_ sender: Any) {
        self.prevSound()
    }
    @IBAction func Next(_ sender: Any) {
        self.nextSound()
        }
    
    func nextSound(){
        if indexSound != arraySound.count - 1{
            audioPlayer.stop()
            indexSound += 1
            sound = arraySound[indexSound]
            self.soundFunc()
            detailImage.image = UIImage(named: tableView.arrayPicture[indexSound])
            audioPlayer.play()
            self.setUpBackgroundMode()
        }
    }
    
    func prevSound() {
        if indexSound != 0{
            indexSound -= 1
            sound = arraySound[indexSound]
            self.soundFunc()
            detailImage.image = UIImage(named: tableView.arrayPicture[indexSound])
            self.setUpBackgroundMode()
        }
    }
   
    func changeButtonImage(_ playing: Bool) {
        if playing {
            playOutlet.setImage(UIImage(named: "pause")!, for: UIControlState())
        } else {
            playOutlet.setImage(UIImage(named: "play")!, for: UIControlState())
        }
    }
    
    func actionPlaySong(_ playing: Bool) {
   
        if playing {
            audioPlayer.pause()
            isPlaying = false
        } else {
            isPlaying = true
            audioPlayer.play()

        setUpBackgroundMode()
        }
    }
}

extension UIViewController {
    func action(swipe: UISwipeGestureRecognizer) {
        
        switch swipe.direction.rawValue {
        case 1:
            performSegue(withIdentifier: "rightSwipe", sender: self)
        default:
            break
        }
    }
}
