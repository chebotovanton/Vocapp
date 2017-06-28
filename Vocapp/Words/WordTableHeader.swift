//
//  WordTableHeader.swift
//  Vocapp
//
//  Created by Aviasales on 28/06/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import UIKit

class WordTableHeader: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!

    func setupWithTitle(title: String) {
        titleLabel.text = title
    }
    
}
