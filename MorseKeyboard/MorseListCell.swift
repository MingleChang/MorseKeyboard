//
//  MorseListCell.swift
//  MorseKeyboard
//
//  Created by admin001 on 15/2/25.
//  Copyright (c) 2015年 Mingle. All rights reserved.
//

import UIKit

class MorseListCell: UITableViewCell {

    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var morseLabel: UILabel!
    @IBOutlet weak var soundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLetter(letter:String,andMorse morse:String){
        self.letterLabel.text=letter
        self.morseLabel.text=morse
    }
}
