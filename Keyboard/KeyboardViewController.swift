//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Mingle Chang on 15/1/11.
//  Copyright (c) 2015年 Mingle. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    let CELL_ID="CellID"
    let AllMorseDic=NSDictionary(contentsOfFile:NSBundle.mainBundle().pathForResource("MorseToChar.plist", ofType: nil)!)
    
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
    }
    
    //MARK: 
    func cleanAllLabel(){
        self.morseLabel.text=""
        self.showResultLabel.text=""
    }
    func changeShift(){
        if(self.checkMorseLabelTextEmpty()){
            
        }else{
            var lText=self.morseLabel.text! as NSString
            lText=lText.substringFromIndex(lText.length-1)
            if(!lText.isEqualToString("/")){
            }
        }
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
        if(self.checkMorseLabelTextEmpty()){
            self.showResultLabel.text=""
            return
        }
        var lString=""
        var lAllMorse=self.morseLabel.text!.componentsSeparatedByString("/")
        var lAllMorseKey=self.AllMorseDic.allKeys as NSArray
        for morse in lAllMorse{
            if(lAllMorseKey.containsObject(morse)){
                lString=lString.stringByAppendingString(self.AllMorseDic.objectForKey(morse) as NSString)
            }else{
                break
            }
        }
        self.showResultLabel.text=lString
    }
    // MARK: Button Click -- 按钮点击事件
    func okButtonClick(sender:UIButton){
        if(!(self.checkMorseLabelTextEmpty()||self.checkShowResultLabelTextEmpty())){
            var proxy=self.textDocumentProxy as UITextDocumentProxy
            proxy.insertText(self.showResultLabel.text!)
            self.cleanAllLabel()
        }
    }
    func hideButtonClick(sender:UIButton){
        self.dismissKeyboard()
    }
    func shiftButtonClick(sender:UIButton){
        self.isShift = !self.isShift
        var shiftImg=UIImage(named: NSString(format: "shift%i.png", self.isShift ? 1 : 0))
        shiftImg=shiftImg?.resetWithColor(UIColor.lightGrayColor())
        self.shiftKeyboardButton.setImage(shiftImg, forState: UIControlState.Normal)
        self.changeShift()
    }
    func deleteButtonClick(sender:UIButton){
        if(self.checkMorseLabelTextEmpty()){
            var proxy=self.textDocumentProxy as UITextDocumentProxy
            proxy.deleteBackward()
        }else{
            var lText=self.morseLabel.text! as NSString
            lText=lText.substringToIndex(lText.length-1)
            self.morseLabel.text=lText
            self.setShowLabelText()
        }
    }
    func spaceButtonClick(sender:UIButton){
        if(self.checkMorseLabelTextEmpty()){
            var proxy=self.textDocumentProxy as UITextDocumentProxy
            proxy.insertText(" ")
        }else{
            self.morseLabel.text=self.morseLabel.text?.stringByAppendingString("/")
        }
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
        var shiftImg=UIImage(named: "shift1.png")
        shiftImg=shiftImg?.resetWithColor(UIColor.lightGrayColor())
        self.shiftKeyboardButton=UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.shiftKeyboardButton.setImage(shiftImg, forState: UIControlState.Normal)
        self.shiftKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.shiftKeyboardButton.addTarget(self, action: "shiftButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.shiftKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.shiftKeyboardButton.layer.cornerRadius=4;
        self.shiftKeyboardButton.layer.shadowColor=UIColor.grayColor().CGColor
        self.shiftKeyboardButton.layer.shadowOffset=CGSizeMake(1, 1);
        self.shiftKeyboardButton.layer.shadowOpacity=1;
        self.view .addSubview(self.shiftKeyboardButton)
        
        //切换键盘按钮
        var nextImg=UIImage(named: "next.png")
        nextImg=nextImg?.resetWithColor(UIColor.lightGrayColor())
        self.nextKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.nextKeyboardButton.setImage(nextImg, forState: UIControlState.Normal)
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextKeyboardButton.addTarget(self, action: "nextButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.nextKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.nextKeyboardButton.layer.cornerRadius=4;
        self.nextKeyboardButton.layer.shadowColor=UIColor.grayColor().CGColor
        self.nextKeyboardButton.layer.shadowOffset=CGSizeMake(1, 1);
        self.nextKeyboardButton.layer.shadowOpacity=1;
        self.view .addSubview(self.nextKeyboardButton)
        
        //删除键盘按钮
        var deleteImg=UIImage(named: "delete.png")
        deleteImg=deleteImg?.resetWithColor(UIColor.lightGrayColor())
        self.deleteKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.deleteKeyboardButton.setImage(deleteImg, forState: UIControlState.Normal)
        self.deleteKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.deleteKeyboardButton.addTarget(self, action: "deleteButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.deleteKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.deleteKeyboardButton.layer.cornerRadius=4;
        self.deleteKeyboardButton.layer.shadowColor=UIColor.grayColor().CGColor
        self.deleteKeyboardButton.layer.shadowOffset=CGSizeMake(1, 1);
        self.deleteKeyboardButton.layer.shadowOpacity=1;
        self.view .addSubview(self.deleteKeyboardButton)
        
        //确认键盘按钮
        self.okKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.okKeyboardButton.setTitle("OK", forState: UIControlState.Normal)
        self.okKeyboardButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        self.okKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.okKeyboardButton.addTarget(self, action: "okButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.okKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.okKeyboardButton.layer.cornerRadius=4;
        self.okKeyboardButton.layer.shadowColor=UIColor.grayColor().CGColor
        self.okKeyboardButton.layer.shadowOffset=CGSizeMake(1, 1);
        self.okKeyboardButton.layer.shadowOpacity=1;
        self.view .addSubview(self.okKeyboardButton)
        
        //收键盘按钮
        var hideImg=UIImage(named: "hide.png")
        hideImg=hideImg?.resetWithColor(UIColor.lightGrayColor())
        self.hideKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.hideKeyboardButton.setImage(hideImg, forState: UIControlState.Normal)
        self.hideKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.hideKeyboardButton.addTarget(self, action: "hideButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.hideKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.hideKeyboardButton.layer.cornerRadius=4;
        self.hideKeyboardButton.layer.shadowColor=UIColor.grayColor().CGColor
        self.hideKeyboardButton.layer.shadowOffset=CGSizeMake(1, 1);
        self.hideKeyboardButton.layer.shadowOpacity=1;
        self.view .addSubview(self.hideKeyboardButton)
        
        //空格键盘按钮
        self.spaceKeyboardButton=UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.spaceKeyboardButton.setTitle("Space Key", forState: UIControlState.Normal)
        self.spaceKeyboardButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        self.spaceKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.spaceKeyboardButton.addTarget(self, action: "spaceButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.spaceKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.spaceKeyboardButton.layer.cornerRadius=4;
        self.spaceKeyboardButton.layer.shadowColor=UIColor.grayColor().CGColor
        self.spaceKeyboardButton.layer.shadowOffset=CGSizeMake(1, 1);
        self.spaceKeyboardButton.layer.shadowOpacity=1;
        self.view .addSubview(self.spaceKeyboardButton)
        
        //展示结果
        self.showResultLabel=UILabel(frame: CGRectZero)
        self.showResultLabel.textColor=UIColor.lightGrayColor()
        self.showResultLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.showResultLabel.textAlignment=NSTextAlignment.Center
        self.showResultLabel.backgroundColor=UIColor.whiteColor()
        self.showResultLabel.layer.cornerRadius=4;
        self.showResultLabel.layer.masksToBounds=true
        self.showResultLabel.layer.shadowColor=UIColor.grayColor().CGColor
        self.showResultLabel.layer.shadowOffset=CGSizeMake(1, 1);
        self.showResultLabel.layer.shadowOpacity=1;
        self.view.addSubview(self.showResultLabel)
        
        //莫斯展示文本
        self.morseLabel=UILabel(frame: CGRectZero)
        self.morseLabel.textColor=UIColor.lightGrayColor()
        self.morseLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.morseLabel.userInteractionEnabled=true
        self.morseLabel.textAlignment=NSTextAlignment.Center
        self.morseLabel.numberOfLines=0
        self.morseLabel.font=UIFont.systemFontOfSize(25)
        self.morseLabel.backgroundColor=UIColor.whiteColor()
        self.morseLabel.layer.cornerRadius=4;
        self.morseLabel.layer.shadowColor=UIColor.grayColor().CGColor
        self.morseLabel.layer.shadowOffset=CGSizeMake(1, 1);
        self.morseLabel.layer.shadowOpacity=1;
        self.view.addSubview(self.morseLabel)
        
        //添加Label的Tap和LongPress手势
        var lTap=UITapGestureRecognizer(target: self, action: "tapGestureRecognizerEvent:")
        self.morseLabel.addGestureRecognizer(lTap)
        
        var lLongPress=UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognizerEvent:")
        self.morseLabel.addGestureRecognizer(lLongPress)
    }
    func initiPadSubView(){
        //大小写切换键盘按钮
        self.shiftKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.shiftKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.shiftKeyboardButton.addTarget(self, action: "shiftButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.shiftKeyboardButton.backgroundColor=UIColor.redColor()
        self.view .addSubview(self.shiftKeyboardButton)
        
        //切换键盘按钮
        self.nextKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextKeyboardButton.addTarget(self, action: "nextButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.nextKeyboardButton.backgroundColor=UIColor.blueColor()
        self.view .addSubview(self.nextKeyboardButton)
        
        //删除键盘按钮
        self.deleteKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.deleteKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.deleteKeyboardButton.backgroundColor=UIColor.brownColor()
        self.deleteKeyboardButton.addTarget(self, action: "deleteButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.deleteKeyboardButton)
        
        //确认键盘按钮
        self.okKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.okKeyboardButton.setTitle("OK", forState: UIControlState.Normal)
        self.okKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.okKeyboardButton.backgroundColor=UIColor.greenColor()
        self.okKeyboardButton.addTarget(self, action: "okButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.okKeyboardButton)
        
        //收键盘按钮
        self.hideKeyboardButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.hideKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.hideKeyboardButton.backgroundColor=UIColor.greenColor()
        self.hideKeyboardButton.addTarget(self, action: "hideButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.hideKeyboardButton)
        
        //空格键盘按钮
        self.spaceKeyboardButton=UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.spaceKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.spaceKeyboardButton.backgroundColor=UIColor.whiteColor()
        self.spaceKeyboardButton.addTarget(self, action: "spaceButtonClick:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view .addSubview(self.spaceKeyboardButton)
        
        //展示结果
        self.showResultLabel=UILabel(frame: CGRectZero)
        self.showResultLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.showResultLabel.backgroundColor=UIColor.yellowColor()
        self.view.addSubview(self.showResultLabel)
        
        //莫斯展示文本
        self.morseLabel=UILabel(frame: CGRectZero)
        self.morseLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.morseLabel.userInteractionEnabled=true
        self.morseLabel.textAlignment=NSTextAlignment.Center
        self.morseLabel.numberOfLines=0
        self.morseLabel.backgroundColor=UIColor.purpleColor()
        self.view.addSubview(self.morseLabel)
        
        //添加Label的Tap和LongPress手势
        var lTap=UITapGestureRecognizer(target: self, action: "tapGestureRecognizerEvent:")
        self.morseLabel.addGestureRecognizer(lTap)
        
        var lLongPress=UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognizerEvent:")
        self.morseLabel.addGestureRecognizer(lLongPress)
    }
    
    func resetiPhoneViewConstraints(){
        //大小写切换键盘按钮
        var shiftKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30.0)
        var shiftKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30.0)
        self.shiftKeyboardButton .addConstraints([shiftKeyboardButtonWidthConstraint, shiftKeyboardButtonHeightConstraint])
        
        var shiftKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 5.0)
        var shiftKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([shiftKeyboardButtonLeftConstraint, shiftKeyboardButtonBottomConstraint])
        
        //切换键盘按钮
        var nextKeyboardButtonWidthConstraint=NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30)
        var nextKeyboardButtonHeightConstraint=NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30)
        self.nextKeyboardButton.addConstraints([nextKeyboardButtonWidthConstraint,nextKeyboardButtonHeightConstraint])
        
        var nextKeyboardButtonLeftConstraint=NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 5)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([nextKeyboardButtonLeftConstraint,nextKeyboardButtonBottomConstraint])
        
        //收键盘按钮
        var hideKeyboardButtonWidthConstraint=NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30)
        var hideKeyboardButtonHeightConstraint=NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30)
        self.hideKeyboardButton.addConstraints([hideKeyboardButtonWidthConstraint,hideKeyboardButtonHeightConstraint])
        
        var hideKeyboardButtonRightConstraint=NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        var hideKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([hideKeyboardButtonRightConstraint,hideKeyboardButtonBottomConstraint])
        
        //空格键盘按钮
        var spaceKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30.0)
        self.spaceKeyboardButton.addConstraints([spaceKeyboardButtonHeightConstraint])
        
        var spaceKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.nextKeyboardButton, attribute:NSLayoutAttribute.Right, multiplier: 1.0, constant: 5.0)
        var spaceKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.hideKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -5.0)
        var spaceKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([spaceKeyboardButtonLeftConstraint, spaceKeyboardButtonRightConstraint,spaceKeyboardButtonBottomConstraint])
        
        //删除键盘按钮
        var deleteKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 60.0)
        var deleteKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30.0)
        self.deleteKeyboardButton .addConstraints([deleteKeyboardButtonWidthConstraint, deleteKeyboardButtonHeightConstraint])
        
        var deleteKeyboardButtonTopConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.view, attribute:NSLayoutAttribute.Top, multiplier: 1.0, constant: 5.0)
        var deleteKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteKeyboardButtonTopConstraint, deleteKeyboardButtonRightConstraint])
        
        //确认键盘按钮
        var okKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 60.0)
        self.okKeyboardButton.addConstraints([okKeyboardButtonWidthConstraint])
        
        var okKeyboardButtonTopConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.deleteKeyboardButton, attribute:NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 5.0)
        var okKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        var okKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.hideKeyboardButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([okKeyboardButtonTopConstraint, okKeyboardButtonRightConstraint,okKeyboardButtonBottomConstraint])
        
        //展示结果
        var showResultLabelHeightConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 30.0)
        self.showResultLabel.addConstraints([showResultLabelHeightConstraint])
        
        var showResultLabelLeftConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute:NSLayoutAttribute.Left, multiplier: 1.0, constant: 5.0)
        var showResultLabelRightConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -5.0)
        var showResultLabelTopConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 5.0)
        self.view.addConstraints([showResultLabelLeftConstraint, showResultLabelRightConstraint,showResultLabelTopConstraint])
        
        //莫斯展示文本
        var morseLabelLeftConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 5.0)
        var morseLabelRightConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.okKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -5.0)
        var morseLabelTopConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.showResultLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 5.0)
        var morseLabelBottomConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([morseLabelLeftConstraint,morseLabelRightConstraint,morseLabelTopConstraint,morseLabelBottomConstraint])
    }
    
    func resetiPadViewConstraints(){
        //大小写切换键盘按钮
        var shiftKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        var shiftKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.shiftKeyboardButton .addConstraints([shiftKeyboardButtonWidthConstraint, shiftKeyboardButtonHeightConstraint])
        
        var shiftKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 5.0)
        var shiftKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.shiftKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([shiftKeyboardButtonLeftConstraint, shiftKeyboardButtonBottomConstraint])
        
        //切换键盘按钮
        var nextKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        var nextKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.nextKeyboardButton .addConstraints([nextKeyboardButtonWidthConstraint, nextKeyboardButtonHeightConstraint])
        
        var nextKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.shiftKeyboardButton, attribute:NSLayoutAttribute.Right, multiplier: 1.0, constant: 10.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([nextKeyboardButtonLeftConstraint, nextKeyboardButtonBottomConstraint])
        
        //删除键盘按钮
        var deleteKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100.0)
        var deleteKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.deleteKeyboardButton .addConstraints([deleteKeyboardButtonWidthConstraint, deleteKeyboardButtonHeightConstraint])
        
        var deleteKeyboardButtonTopConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.view, attribute:NSLayoutAttribute.Top, multiplier: 1.0, constant: 5.0)
        var deleteKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteKeyboardButtonTopConstraint, deleteKeyboardButtonRightConstraint])
        
        //确认键盘按钮
        var okKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 100.0)
        self.okKeyboardButton.addConstraints([okKeyboardButtonWidthConstraint])
        
        var okKeyboardButtonTopConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.deleteKeyboardButton, attribute:NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        var okKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -5.0)
        var okKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.okKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([okKeyboardButtonTopConstraint, okKeyboardButtonRightConstraint,okKeyboardButtonBottomConstraint])
        
        //收键盘按钮
        var hideKeyboardButtonWidthConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        var hideKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.hideKeyboardButton.addConstraints([hideKeyboardButtonWidthConstraint,hideKeyboardButtonHeightConstraint])
        
        var hideKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.okKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -10.0)
        var hideKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.hideKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([hideKeyboardButtonRightConstraint, hideKeyboardButtonBottomConstraint])
        
        //空格键盘按钮
        var spaceKeyboardButtonHeightConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.spaceKeyboardButton.addConstraints([spaceKeyboardButtonHeightConstraint])
        
        var spaceKeyboardButtonLeftConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Left, relatedBy: .Equal, toItem: self.nextKeyboardButton, attribute:NSLayoutAttribute.Right, multiplier: 1.0, constant: 10.0)
        var spaceKeyboardButtonRightConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Right, relatedBy: .Equal, toItem: self.hideKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -10.0)
        var spaceKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Bottom, relatedBy: .Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([spaceKeyboardButtonLeftConstraint, spaceKeyboardButtonRightConstraint,spaceKeyboardButtonBottomConstraint])
        
        //展示结果
        var showResultLabelHeightConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 50.0)
        self.showResultLabel.addConstraints([showResultLabelHeightConstraint])
        
        var showResultLabelLeftConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute:NSLayoutAttribute.Left, multiplier: 1.0, constant: 5.0)
        var showResultLabelRightConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.deleteKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -10.0)
        var showResultLabelTopConstraint = NSLayoutConstraint(item: self.showResultLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 5.0)
        self.view.addConstraints([showResultLabelLeftConstraint, showResultLabelRightConstraint,showResultLabelTopConstraint])
        
        //莫斯展示文本
        var morseLabelLeftConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 5.0)
        var morseLabelRightConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.okKeyboardButton, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: -10.0)
        var morseLabelTopConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.showResultLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 10.0)
        var morseLabelBottomConstraint=NSLayoutConstraint(item: self.morseLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.spaceKeyboardButton, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: -10.0)
        self.view.addConstraints([morseLabelLeftConstraint,morseLabelRightConstraint,morseLabelTopConstraint,morseLabelBottomConstraint])
    }
}
