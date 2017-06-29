//
//  WordExampleCell.swift
//  Vocapp
//
//  Created by Aviasales on 27/06/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import UIKit

class WordExampleCell: UICollectionViewCell {

    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var translation: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.layer.cornerRadius = 12
        let value = CGFloat(129.0 / 255.0)
        contentView.backgroundColor = UIColor(red: value, green: value, blue: value, alpha: 0.7)
    }

    func setup(_ example: WordExample) {
        text.text = example.text
        translation.text = example.translation
    }
}
