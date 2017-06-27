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

        contentView.layer.cornerRadius = 10
    }

    func setup(_ example: WordExample) {
        text.text = example.text
        translation.text = example.translation
    }
}
