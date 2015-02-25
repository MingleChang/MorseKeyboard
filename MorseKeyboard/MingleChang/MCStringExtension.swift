//
//  MCStringExtension.swift
//  Category_Swift
//
//  Created by admin001 on 14/12/2.
//  Copyright (c) 2014年 MingleChang. All rights reserved.
//

import Foundation


extension NSString{
    
    func isEmpty()->Bool{
        if self.isKindOfClass(NSString)&&self.isEqualToString(""){
            return true
        }
        return false
    }
    
    func isAllSpaceAndNewLine()->Bool{
        let lResultString=self.trimSpaceAndNewLine()
        if lResultString.length==0{
            return true
        }
        return false
    }
    
    func trimSpaceAndNewLine()->NSString{
        let lCharacterSet=NSCharacterSet.whitespaceAndNewlineCharacterSet()
        let lResultString=self.stringByTrimmingCharactersInSet(lCharacterSet)
        return lResultString
    }
    
//    func md5()->NSString{
//        var cStr=self.UTF8String
//        var buffer=UnsafeMutablePointer<UInt8>.alloc(16)
//        CC_MD5(cStr, (CC_LONG)(strlen(cStr)), buffer)
//        let md5String=NSMutableString(capacity: 16*2)
//        for index in 0...15{
//            md5String.appendFormat("%02X", buffer[index])
//        }
//        return md5String
//    }
}
extension String{
    func lastString()->String{
        let lStartIndex=advance(self.endIndex, -1)
        let lEndIndex=advance(self.endIndex, 0)
        let lRange=Range(start: lStartIndex, end: lEndIndex)
        return self.substringWithRange(lRange)
    }
    func stringByRemoveLastString()->String{
        let lEndIndex=advance(self.endIndex, -1)
        let lRange=Range(start: self.startIndex, end: lEndIndex)
        return self.substringWithRange(lRange)
    }
}