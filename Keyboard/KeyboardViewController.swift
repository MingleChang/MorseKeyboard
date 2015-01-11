//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Mingle Chang on 15/1/11.
//  Copyright (c) 2015年 Mingle. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var okKeyboardButton: UIButton!
    @IBOutlet var spaceKeyboardButton: UIButton!
    @IBOutlet var hideKeyboardButton: UIButton!
    @IBOutlet var deleteKeyboardButton: UIButton!
    @IBOutlet var shiftKeyboardButton: UIButton!
    @IBOutlet var showResultCollectionView: UICollectionView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Perform custom UI setup here
        self.initAllSubViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }
    // MARK: Button Click -- 按钮点击事件
    func okButtonClick(sender:UIButton){
        
    }
    func hideButtonClick(sender:UIButton){
        self.dismissKeyboard()
    }
    func shiftButtonClick(sender:UIButton){
        
    }
    func deleteButtonClick(sender:UIButton){
        
    }
    func spaceButtonClick(sender:UIButton){
        
    }
    func nextButtonClick(sender:UIButton){
        self.advanceToNextInputMode()
    }
    // MARK: Init All SubViews -- 初始化视图
    func initAllSubViews(){
        if(UIDevice.currentDevice().userInterfaceIdiom==UIUserInterfaceIdiom.Phone){
            self.initiPhoneSubView()
        }else{
            self.initiPadSubView()
        }
    }
    
    func initiPhoneSubView(){
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextKeyboardButton.addTarget(self, action: "nextButtonClick:", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.nextKeyboardButton)
        
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }
    func initiPadSubView(){
        //大小写切换键盘按钮
        self.shiftKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.shiftKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.shiftKeyboardButton.addTarget(self, action: "shiftButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.shiftKeyboardButton.backgroundColor=UIColor.redColor()
        self.view .addSubview(self.shiftKeyboardButton)
        
        var shiftKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        var shiftKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.shiftKeyboardButton .addConstraints([shiftKeyboardButtonWidthConstraint, shiftKeyboardButtonHeightConstraint])
        
        var shiftKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 5.0)
        var shiftKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([shiftKeyboardButtonLeftConstraint, shiftKeyboardButtonBottomConstraint])
        
        //切换键盘按钮
        self.nextKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextKeyboardButton.addTarget(self, action: "nextButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.nextKeyboardButton.backgroundColor=UIColor.blueColor()
        self.view .addSubview(self.nextKeyboardButton)
        
        var nextKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        var nextKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.nextKeyboardButton .addConstraints([nextKeyboardButtonWidthConstraint, nextKeyboardButtonHeightConstraint])
        
        var nextKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.shiftKeyboardButton, attribute:NSLayoutAttribute.Right, multiplier: 1.0, constant: 10.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([nextKeyboardButtonLeftConstraint, nextKeyboardButtonBottomConstraint])
        
        //删除键盘按钮
        self.deleteKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.deleteKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.deleteKeyboardButton.backgroundColor=UIColor.brownColor()
        self.deleteKeyboardButton.addTarget(self, action: "deleteButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.deleteKeyboardButton)
        
        var deleteKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100.0)
        var deleteKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.deleteKeyboardButton .addConstraints([deleteKeyboardButtonWidthConstraint, deleteKeyboardButtonHeightConstraint])
        
        var deleteKeyboardButtonTopConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.view, attribute:NSLayoutAttribute.Top, multiplier: 1.0, constant: 5.0)
        var deleteKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteKeyboardButtonTopConstraint, deleteKeyboardButtonRightConstraint])
        
        //确认键盘按钮
        self.okKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.okKeyboardButton.setTitle("OK", forState: UIControlState.Normal)
        self.okKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.okKeyboardButton.backgroundColor=UIColor.greenColor()
        self.okKeyboardButton.addTarget(self, action: "okButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.okKeyboardButton)
        
        var okKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100.0)
        self.okKeyboardButton.addConstraints([okKeyboardButtonWidthConstraint])

        var okKeyboardButtonTopConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.deleteKeyboardButton, attribute:NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        var okKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        var okKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([okKeyboardButtonTopConstraint, okKeyboardButtonRightConstraint,okKeyboardButtonBottomConstraint])
        
        //收键盘按钮
        self.hideKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.hideKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.hideKeyboardButton.backgroundColor=UIColor.greenColor()
        self.hideKeyboardButton.addTarget(self, action: "hideButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.hideKeyboardButton)
        
        var hideKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        var hideKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.hideKeyboardButton.addConstraints([hideKeyboardButtonWidthConstraint,hideKeyboardButtonHeightConstraint])
        
        var hideKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.okKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -10.0)
        var hideKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([hideKeyboardButtonRightConstraint, hideKeyboardButtonBottomConstraint])
        
        //空格键盘按钮
        self.spaceKeyboardButton=UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.spaceKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.spaceKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.spaceKeyboardButton.addTarget(self, action: "spaceButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.spaceKeyboardButton)
        
        var spaceKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.spaceKeyboardButton.addConstraints([spaceKeyboardButtonHeightConstraint])
        
        var spaceKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Left, relatedBy: .Equal, toItem: self.nextKeyboardButton, attribute:NSLayoutAttribute.Right, multiplier: 1.0, constant: 10.0)
        var spaceKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.hideKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -10.0)
        var spaceKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([spaceKeyboardButtonLeftConstraint, spaceKeyboardButtonRightConstraint,spaceKeyboardButtonBottomConstraint])
        
        //展示结果
        
    }
}
