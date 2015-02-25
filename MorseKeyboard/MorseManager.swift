//
//  MorseManager.swift
//  MorseKeyboard
//
//  Created by admin001 on 15/2/25.
//  Copyright (c) 2015年 Mingle. All rights reserved.
//

import UIKit

class MorseManager{
    class var sharedInstance: MorseManager {
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
