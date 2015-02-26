//
//  ViewController.swift
//  MorseKeyboard
//
//  Created by Mingle Chang on 15/1/11.
//  Copyright (c) 2015年 Mingle. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var lPlayer:AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let lString=NSBundle.mainBundle().pathForResource("shake_sound", ofType: "mp3")
        let lURL=NSURL(string: lString!)
        lPlayer=AVAudioPlayer(contentsOfURL: lURL, error: nil)
        lPlayer.volume=1
        lPlayer.prepareToPlay()
        lPlayer.play()
    }
}

