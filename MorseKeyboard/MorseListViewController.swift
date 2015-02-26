//
//  MorseListViewController.swift
//  MorseKeyboard
//
//  Created by admin001 on 15/2/25.
//  Copyright (c) 2015年 Mingle. All rights reserved.
//

import UIKit
import AVFoundation

class MorseListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let MorseCellID="MorseListCellID"
    var lPlayer:AVAudioPlayer!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:
    func playSoundWithIndexPath(indexPath:NSIndexPath){
        let row=indexPath.row
        let letter=MorseManager.sharedInstance().CharArray[row] as String
        let fileName=MorseManager.sharedInstance().CharToSoundDic[letter] as String
        let lString=NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")
        let lURL=NSURL(string: lString!)
        lPlayer=AVAudioPlayer(contentsOfURL: lURL, error: nil)
        lPlayer.prepareToPlay()
        lPlayer.play()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MorseManager.sharedInstance().CharArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var lCell=tableView.dequeueReusableCellWithIdentifier(MorseCellID, forIndexPath: indexPath) as MorseListCell
        
        let row=indexPath.row
        let letter=MorseManager.sharedInstance().CharArray[row] as String
        let morse=MorseManager.sharedInstance().CharToMorseDic[letter] as String
        
        lCell.setLetter(letter, andMorse: morse)
        
        return lCell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView .deselectRowAtIndexPath(indexPath, animated: true)
        self.playSoundWithIndexPath(indexPath)
    }
}
