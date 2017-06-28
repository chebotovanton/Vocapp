//
//  Section.swift
//  Vocapp
//
//  Created by Aviasales on 27/06/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import UIKit

class Section: NSObject {
    let title: String
    let examples: [WordExample]

    init(title:String, examples: [WordExample]) {
        self.title = title
        self.examples = examples
    }
}
