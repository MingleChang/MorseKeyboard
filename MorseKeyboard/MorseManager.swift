//
//  MorseManager.swift
//  MorseKeyboard
//
//  Created by admin001 on 15/2/25.
//  Copyright (c) 2015年 Mingle. All rights reserved.
//

import UIKit

class MorseManager{
    
    let CharToSoundDic=NSDictionary(contentsOfFile:NSBundle.mainBundle().pathForResource("CharToSound.plist", ofType: nil)!)!
    let MorseToCharDic=NSDictionary(contentsOfFile:NSBundle.mainBundle().pathForResource("MorseToChar.plist", ofType: nil)!)!
    let CharToMorseDic=NSDictionary(contentsOfFile:NSBundle.mainBundle().pathForResource("CharToMorse.plist", ofType: nil)!)!
    let CharArray=NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("CharArray.plist", ofType: nil)!)!
    class func sharedInstance() -> MorseManager{
        struct MCStatic {
            static var onceToken: dispatch_once_t = 0
            static var instance: MorseManager? = nil
        }

        dispatch_once(&MCStatic.onceToken) {
            MCStatic.instance = MorseManager()
        }
        return MCStatic.instance!
    }
}
