//
//  HourCell.swift
//  Vocapp
//
//  Created by Anton Chebotov on 02/07/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import UIKit

class HourCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!

    func setup(_ hour: HourObject) {
        label.text = String(hour.value)
        label.alpha = 0.2
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                label.alpha = 1.0
                label.font = UIFont.systemFont(ofSize: 80, weight: UIFontWeightMedium)
            } else {
                label.alpha = 0.2
                label.font = UIFont.systemFont(ofSize: 80, weight: UIFontWeightLight)
            }
        }
    }

}
