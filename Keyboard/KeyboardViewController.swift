//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Mingle Chang on 15/1/11.
//  Copyright (c) 2015年 Mingle. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    let CornerRadius:CGFloat=2.0
    
    var isShift:Bool=true
    
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var okKeyboardButton: UIButton!
    @IBOutlet var spaceKeyboardButton: UIButton!
    @IBOutlet var hideKeyboardButton: UIButton!
    @IBOutlet var deleteKeyboardButton: UIButton!
    @IBOutlet var shiftKeyboardButton: UIButton!
    @IBOutlet var showResultLabel: UILabel!
    @IBOutlet var morseLabel: UILabel!
    
    var allInfo:NSArray!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
//        self.resetViewConstraints()
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

//    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
//    }

//    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
        
//        var textColor: UIColor
//        var proxy = self.textDocumentProxy as UITextDocumentProxy
//        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
//            textColor = UIColor.whiteColor()
//        } else {
//            textColor = UIColor.blackColor()
//        }
//    }
    
    //MARK: 
    func cleanAllLabel(){
        self.morseLabel.text=""
        self.showResultLabel.text=""
    }
    func changeShift(){
        if(self.checkMorseLabelTextEmpty()||self.checkShowResultLabelTextEmpty()){
            return
        }
        if(self.morseLabel.text!.lastString()=="/"){
            return
        }
        let lAllMorse=self.morseLabel.text!.componentsSeparatedByString("/")
        if(lAllMorse.count>self.showResultLabel.text!.length()){
            return
        }
        let lLastString=self.showResultLabel.text!.lastString()
        let lRemoveLastString=self.showResultLabel.text!.stringByRemoveLastString()
        self.showResultLabel.text=lRemoveLastString + (self.isShift ? lLastString.uppercaseString : lLastString.lowercaseString)
    }
    func checkMorseLabelTextEmpty()->Bool{
        if(self.morseLabel.text == nil){
            return true
        }else if(self.morseLabel.text!.isEmpty){
            return true
        }else{
            return false
        }
    }
    func checkShowResultLabelTextEmpty()->Bool{
        if(self.showResultLabel.text == nil){
            return true
        }else if(self.showResultLabel.text!.isEmpty){
            return true
        }else{
            return false
        }
    }
    
    func setShowLabelText(){
        if(self.showResultLabel.text == nil){
            self.showResultLabel.text=""
        }
        if(self.checkMorseLabelTextEmpty()){
            self.showResultLabel.text=""
            return
        }
        let lAllMorse=self.morseLabel.text!.componentsSeparatedByString("/") as Array
        let lMorse=lAllMorse.last as String!
//        let lAllMorseKey=MorseManager.sharedInstance().MorseToCharDic.allKeys
        var lString:String?=MorseManager.sharedInstance().MorseToCharDic.objectForKey(lMorse) as? String
        if(lString == nil){
            lString = ""
        }
        
        if(self.showResultLabel.text!.length() < lAllMorse.count){
            self.showResultLabel.text=self.showResultLabel.text! + (self.isShift ? lString!.uppercaseString : lString!.lowercaseString)
        }else{
            self.showResultLabel.text=self.showResultLabel.text!.stringByRemoveLastString() + (self.isShift ? lString!.uppercaseString : lString!.lowercaseString)
        }
    }
    // MARK: Button Click -- 按钮点击事件
    func okButtonClick(sender:UIButton){
        if(!(self.checkMorseLabelTextEmpty()||self.checkShowResultLabelTextEmpty())){
            let proxy=self.textDocumentProxy as UITextDocumentProxy
            proxy.insertText(self.showResultLabel.text!)
            self.cleanAllLabel()
        }
    }
    func hideButtonClick(sender:UIButton){
        self.dismissKeyboard()
    }
    func shiftButtonClick(sender:UIButton){
        self.isShift = !self.isShift
        var shiftImg=UIImage(named: NSString(format: "Shift%i.png", self.isShift ? 1 : 0) as String)
        shiftImg=shiftImg?.resetWithColor(UIColor.lightGrayColor())
        self.shiftKeyboardButton.setImage(shiftImg, forState: UIControlState.Normal)
        self.changeShift()
    }
    func deleteButtonClick(sender:UIButton){
        if(self.checkMorseLabelTextEmpty()){
            let proxy=self.textDocumentProxy as UITextDocumentProxy
            proxy.deleteBackward()
            return
        }
        if(self.morseLabel.text!.lastString()=="/"){
            self.morseLabel.text=self.morseLabel.text!.stringByRemoveLastString()
        }else{
            self.morseLabel.text=self.morseLabel.text!.stringByRemoveLastString()
            self.setShowLabelText()
        }
    }
    func spaceButtonClick(sender:UIButton){
        if(self.checkMorseLabelTextEmpty()){
            let proxy=self.textDocumentProxy as UITextDocumentProxy
            proxy.insertText(" ")
            return
        }
        if(self.morseLabel.text!.lastString()=="/"){
            return
        }
        self.isShift = false
        var shiftImg=UIImage(named: NSString(format: "Shift%i.png", self.isShift ? 1 : 0) as String)
        shiftImg=shiftImg?.resetWithColor(UIColor.lightGrayColor())
        self.shiftKeyboardButton.setImage(shiftImg, forState: UIControlState.Normal)
        self.morseLabel.text=self.morseLabel.text?.stringByAppendingString("/")
    }
    func nextButtonClick(sender:UIButton){
        self.advanceToNextInputMode()
    }
    func tapGestureRecognizerEvent(sender:UITapGestureRecognizer){
        if(self.checkMorseLabelTextEmpty()){
            self.morseLabel.text="·"
        }else{
            self.morseLabel.text=self.morseLabel.text?.stringByAppendingString("·")
        }
        self.setShowLabelText()
    }
    func longPressGestureRecognizerEvent(sender:UILongPressGestureRecognizer){
        if(sender.state==UIGestureRecognizerState.Began){
            if(self.checkMorseLabelTextEmpty()){
                self.morseLabel.text="-"
            }else{
                self.morseLabel.text=self.morseLabel.text?.stringByAppendingString("-")
            }
        }
        self.setShowLabelText()
    }
    
    // MARK: Init All SubViews -- 初始化视图
    func initAllData(){
        self.allInfo=NSArray()
    }
    func initAllSubViews(){
        self.view.backgroundColor=UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.2)
        if(UIDevice.currentDevice().userInterfaceIdiom==UIUserInterfaceIdiom.Phone){
            self.initiPhoneSubView()
            self.resetiPhoneViewConstraints()
        }else{
            self.initiPadSubView()
            self.resetiPadViewConstraints()
        }
    }
    
    func resetViewConstraints(){
        if(UIDevice.currentDevice().userInterfaceIdiom==UIUserInterfaceIdiom.Phone){
            self.resetiPhoneViewConstraints()
        }else{
            self.resetiPadViewConstraints()
        }
    }
    
    func initiPhoneSubView(){
        //大小写切换键盘按钮
        var shiftImg=UIImage(named: "Shift1.png")
        shiftImg=shiftImg?.resetWithColor(UIColor.lightGrayColor())
        
        self.shiftKeyboardButton=UIButton(type: UIButtonType.Custom)
        self.shiftKeyboardButton.setImage(shiftImg, forState: UIControlState.Normal)
        self.shiftKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.shiftKeyboardButton.addTarget(self, action: "shiftButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.shiftKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.shiftKeyboardButton.layer.cornerRadius=CornerRadius;
        self.view .addSubview(self.shiftKeyboardButton)
        
        //切换键盘按钮
        var nextImg=UIImage(named: "Next.png")
        nextImg=nextImg?.resetWithColor(UIColor.lightGrayColor())
        self.nextKeyboardButton = UIButton(type: UIButtonType.Custom)
        self.nextKeyboardButton.setImage(nextImg, forState: UIControlState.Normal)
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.nextKeyboardButton.addTarget(self, action: "nextButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.nextKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.nextKeyboardButton.layer.cornerRadius=CornerRadius;
        self.view .addSubview(self.nextKeyboardButton)
        
        //删除键盘按钮
        var deleteImg=UIImage(named: "Delete.png")
        deleteImg=deleteImg?.resetWithColor(UIColor.lightGrayColor())
        self.deleteKeyboardButton = UIButton(type: UIButtonType.Custom)
        self.deleteKeyboardButton.setImage(deleteImg, forState: UIControlState.Normal)
        self.deleteKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.deleteKeyboardButton.addTarget(self, action: "deleteButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.deleteKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.deleteKeyboardButton.layer.cornerRadius=CornerRadius;
        self.view .addSubview(self.deleteKeyboardButton)
        
        //确认键盘按钮
        self.okKeyboardButton = UIButton(type: UIButtonType.Custom)
        self.okKeyboardButton.setTitle("OK", forState: UIControlState.Normal)
        self.okKeyboardButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        self.okKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.okKeyboardButton.addTarget(self, action: "okButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.okKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.okKeyboardButton.layer.cornerRadius=CornerRadius;
        self.view .addSubview(self.okKeyboardButton)
        
        //收键盘按钮
        var hideImg=UIImage(named: "Hide.png")
        hideImg=hideImg?.resetWithColor(UIColor.lightGrayColor())
        self.hideKeyboardButton = UIButton(type: UIButtonType.Custom)
        self.hideKeyboardButton.setImage(hideImg, forState: UIControlState.Normal)
        self.hideKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.hideKeyboardButton.addTarget(self, action: "hideButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.hideKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.hideKeyboardButton.layer.cornerRadius=CornerRadius;
        self.view .addSubview(self.hideKeyboardButton)
        
        //空格键盘按钮
        self.spaceKeyboardButton=UIButton(type: UIButtonType.Custom)
        self.spaceKeyboardButton.setTitle("Space Key", forState: UIControlState.Normal)
        self.spaceKeyboardButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        self.spaceKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.spaceKeyboardButton.addTarget(self, action: "spaceButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.spaceKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.spaceKeyboardButton.layer.cornerRadius=CornerRadius;
        self.view .addSubview(self.spaceKeyboardButton)
        
        //展示结果
        self.showResultLabel=UILabel(frame: CGRectZero)
        self.showResultLabel.textColor=UIColor.lightGrayColor()
        self.showResultLabel.translatesAutoresizingMaskIntoConstraints=false
        self.showResultLabel.textAlignment=NSTextAlignment.Center
        self.showResultLabel.backgroundColor=UIColor.whiteColor()
        self.showResultLabel.layer.cornerRadius=CornerRadius;
        self.showResultLabel.layer.masksToBounds=true
        self.view.addSubview(self.showResultLabel)
        
        //莫斯展示文本
        self.morseLabel=UILabel(frame: CGRectZero)
        self.morseLabel.textColor=UIColor.lightGrayColor()
        self.morseLabel.translatesAutoresizingMaskIntoConstraints=false
        self.morseLabel.userInteractionEnabled=true
        self.morseLabel.textAlignment=NSTextAlignment.Center
        self.morseLabel.numberOfLines=0
        self.morseLabel.font=UIFont.systemFontOfSize(25)
        self.morseLabel.backgroundColor=UIColor.whiteColor()
        self.morseLabel.layer.cornerRadius=CornerRadius;
        self.morseLabel.layer.masksToBounds=true
        self.view.addSubview(self.morseLabel)
        
        //添加Label的Tap和LongPress手势
        let lTap=UITapGestureRecognizer(target: self, action: "tapGestureRecognizerEvent:")
        self.morseLabel.addGestureRecognizer(lTap)
        
        let lLongPress=UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognizerEvent:")
        self.morseLabel.addGestureRecognizer(lLongPress)
    }
    func initiPadSubView(){
        //大小写切换键盘按钮
        self.shiftKeyboardButton = UIButton(type: UIButtonType.Custom)
        self.shiftKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.shiftKeyboardButton.addTarget(self, action: "shiftButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.shiftKeyboardButton.backgroundColor=UIColor.redColor()
        self.view .addSubview(self.shiftKeyboardButton)
        
        //切换键盘按钮
        self.nextKeyboardButton = UIButton(type: UIButtonType.Custom)
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.nextKeyboardButton.addTarget(self, action: "nextButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.nextKeyboardButton.backgroundColor=UIColor.blueColor()
        self.view .addSubview(self.nextKeyboardButton)
        
        //删除键盘按钮
        self.deleteKeyboardButton = UIButton(type: UIButtonType.Custom)
        self.deleteKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.deleteKeyboardButton.backgroundColor=UIColor.brownColor()
        self.deleteKeyboardButton.addTarget(self, action: "deleteButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.deleteKeyboardButton)
        
        //确认键盘按钮
        self.okKeyboardButton = UIButton(type: UIButtonType.Custom)
        self.okKeyboardButton.setTitle("OK", forState: UIControlState.Normal)
        self.okKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.okKeyboardButton.backgroundColor=UIColor.greenColor()
        self.okKeyboardButton.addTarget(self, action: "okButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.okKeyboardButton)
        
        //收键盘按钮
        self.hideKeyboardButton = UIButton(type: UIButtonType.Custom)
        self.hideKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.hideKeyboardButton.backgroundColor=UIColor.greenColor()
        self.hideKeyboardButton.addTarget(self, action: "hideButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.hideKeyboardButton)
        
        //空格键盘按钮
        self.spaceKeyboardButton=UIButton(type: UIButtonType.Custom)
        self.spaceKeyboardButton.translatesAutoresizingMaskIntoConstraints=false
        self.spaceKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.spaceKeyboardButton.addTarget(self, action: "spaceButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.spaceKeyboardButton)
        
        //展示结果
        self.showResultLabel=UILabel(frame: CGRectZero)
        self.showResultLabel.translatesAutoresizingMaskIntoConstraints=false
        self.showResultLabel.backgroundColor=UIColor.yellowColor()
        self.view.addSubview(self.showResultLabel)
        
        //莫斯展示文本
        self.morseLabel=UILabel(frame: CGRectZero)
        self.morseLabel.translatesAutoresizingMaskIntoConstraints=false
        self.morseLabel.userInteractionEnabled=true
        self.morseLabel.textAlignment=NSTextAlignment.Center
        self.morseLabel.numberOfLines=0
        self.morseLabel.backgroundColor=UIColor.purpleColor()
        self.view.addSubview(self.morseLabel)
        
        //添加Label的Tap和LongPress手势
        let lTap=UITapGestureRecognizer(target: self, action: "tapGestureRecognizerEvent:")
        self.morseLabel.addGestureRecognizer(lTap)
        
        let lLongPress=UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognizerEvent:")
        self.morseLabel.addGestureRecognizer(lLongPress)
    }
    
    func resetiPhoneViewConstraints(){
        //大小写切换键盘按钮
        let shiftKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30.0)
        let shiftKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30.0)
        self.shiftKeyboardButton .addConstraints([shiftKeyboardButtonWidthConstraint, shiftKeyboardButtonHeightConstraint])
        
        let shiftKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 5.0)
        let shiftKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([shiftKeyboardButtonLeftConstraint, shiftKeyboardButtonBottomConstraint])
        
        //切换键盘按钮
        let nextKeyboardButtonWidthConstraint=NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30)
        let nextKeyboardButtonHeightConstraint=NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30)
        self.nextKeyboardButton.addConstraints([nextKeyboardButtonWidthConstraint,nextKeyboardButtonHeightConstraint])
        
        let nextKeyboardButtonLeftConstraint=NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 5)
        let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([nextKeyboardButtonLeftConstraint,nextKeyboardButtonBottomConstraint])
        
        //收键盘按钮
        let hideKeyboardButtonWidthConstraint=NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30)
        let hideKeyboardButtonHeightConstraint=NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30)
        self.hideKeyboardButton.addConstraints([hideKeyboardButtonWidthConstraint,hideKeyboardButtonHeightConstraint])
        
        let hideKeyboardButtonRightConstraint=NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        let hideKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([hideKeyboardButtonRightConstraint,hideKeyboardButtonBottomConstraint])
        
        //空格键盘按钮
        let spaceKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30.0)
        self.spaceKeyboardButton.addConstraints([spaceKeyboardButtonHeightConstraint])
        
        let spaceKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.nextKeyboardButton, attribute:NSLayoutAttribute.Right, multiplier: 1.0, constant: 5.0)
        let spaceKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.hideKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -5.0)
        let spaceKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([spaceKeyboardButtonLeftConstraint, spaceKeyboardButtonRightConstraint,spaceKeyboardButtonBottomConstraint])
        
        //删除键盘按钮
        let deleteKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 60.0)
        let deleteKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30.0)
        self.deleteKeyboardButton .addConstraints([deleteKeyboardButtonWidthConstraint, deleteKeyboardButtonHeightConstraint])
        
        let deleteKeyboardButtonTopConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.view, attribute:NSLayoutAttribute.Top, multiplier: 1.0, constant: 5.0)
        let deleteKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteKeyboardButtonTopConstraint, deleteKeyboardButtonRightConstraint])
        
        //确认键盘按钮
        let okKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 60.0)
        self.okKeyboardButton.addConstraints([okKeyboardButtonWidthConstraint])
        
        let okKeyboardButtonTopConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.deleteKeyboardButton, attribute:NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 5.0)
        let okKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        let okKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.hideKeyboardButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([okKeyboardButtonTopConstraint, okKeyboardButtonRightConstraint,okKeyboardButtonBottomConstraint])
        
        //展示结果
        let showResultLabelHeightConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30.0)
        self.showResultLabel.addConstraints([showResultLabelHeightConstraint])
        
        let showResultLabelLeftConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute:NSLayoutAttribute.Left, multiplier: 1.0, constant: 5.0)
        let showResultLabelRightConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -5.0)
        let showResultLabelTopConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 5.0)
        self.view.addConstraints([showResultLabelLeftConstraint, showResultLabelRightConstraint,showResultLabelTopConstraint])
        
        //莫斯展示文本
        let morseLabelLeftConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 5.0)
        let morseLabelRightConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.okKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -5.0)
        let morseLabelTopConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.showResultLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 5.0)
        let morseLabelBottomConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([morseLabelLeftConstraint,morseLabelRightConstraint,morseLabelTopConstraint,morseLabelBottomConstraint])
    }
    
    func resetiPadViewConstraints(){
        //大小写切换键盘按钮
        let shiftKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        let shiftKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.shiftKeyboardButton .addConstraints([shiftKeyboardButtonWidthConstraint, shiftKeyboardButtonHeightConstraint])
        
        let shiftKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 5.0)
        let shiftKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([shiftKeyboardButtonLeftConstraint, shiftKeyboardButtonBottomConstraint])
        
        //切换键盘按钮
        let nextKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        let nextKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.nextKeyboardButton .addConstraints([nextKeyboardButtonWidthConstraint, nextKeyboardButtonHeightConstraint])
        
        let nextKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.shiftKeyboardButton, attribute:NSLayoutAttribute.Right, multiplier: 1.0, constant: 10.0)
        let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([nextKeyboardButtonLeftConstraint, nextKeyboardButtonBottomConstraint])
        
        //删除键盘按钮
        let deleteKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100.0)
        let deleteKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.deleteKeyboardButton .addConstraints([deleteKeyboardButtonWidthConstraint, deleteKeyboardButtonHeightConstraint])
        
        let deleteKeyboardButtonTopConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.view, attribute:NSLayoutAttribute.Top, multiplier: 1.0, constant: 5.0)
        let deleteKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteKeyboardButtonTopConstraint, deleteKeyboardButtonRightConstraint])
        
        //确认键盘按钮
        let okKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100.0)
        self.okKeyboardButton.addConstraints([okKeyboardButtonWidthConstraint])
        
        let okKeyboardButtonTopConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.deleteKeyboardButton, attribute:NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        let okKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        let okKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([okKeyboardButtonTopConstraint, okKeyboardButtonRightConstraint,okKeyboardButtonBottomConstraint])
        
        //收键盘按钮
        let hideKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        let hideKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.hideKeyboardButton.addConstraints([hideKeyboardButtonWidthConstraint,hideKeyboardButtonHeightConstraint])
        
        let hideKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.okKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -10.0)
        let hideKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([hideKeyboardButtonRightConstraint, hideKeyboardButtonBottomConstraint])
        
        //空格键盘按钮
        let spaceKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.spaceKeyboardButton.addConstraints([spaceKeyboardButtonHeightConstraint])
        
        let spaceKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Left, relatedBy: .Equal, toItem: self.nextKeyboardButton, attribute:NSLayoutAttribute.Right, multiplier: 1.0, constant: 10.0)
        let spaceKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.hideKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -10.0)
        let spaceKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([spaceKeyboardButtonLeftConstraint, spaceKeyboardButtonRightConstraint,spaceKeyboardButtonBottomConstraint])
        
        //展示结果
        let showResultLabelHeightConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.showResultLabel.addConstraints([showResultLabelHeightConstraint])
        
        let showResultLabelLeftConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute:NSLayoutAttribute.Left, multiplier: 1.0, constant: 5.0)
        let showResultLabelRightConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -10.0)
        let showResultLabelTopConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 5.0)
        self.view.addConstraints([showResultLabelLeftConstraint, showResultLabelRightConstraint,showResultLabelTopConstraint])
        
        //莫斯展示文本
        let morseLabelLeftConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 5.0)
        let morseLabelRightConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.okKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -10.0)
        let morseLabelTopConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.showResultLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        let morseLabelBottomConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -10.0)
        self.view.addConstraints([morseLabelLeftConstraint,morseLabelRightConstraint,morseLabelTopConstraint,morseLabelBottomConstraint])
    }
}
