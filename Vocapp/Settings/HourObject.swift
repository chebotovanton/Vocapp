//
//  HourObject.swift
//  Vocapp
//
//  Created by Anton Chebotov on 02/07/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import UIKit

class HourObject: NSObject, NSCoding {

    private static let kValueDefaultsKey = "kValueDefaultsKey"

    let value: Int

    init(_ value: Int) {
        self.value = value
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(value, forKey: HourObject.kValueDefaultsKey)
    }

    public required init?(coder aDecoder: NSCoder) {
        self.value = Int(aDecoder.decodeInteger(forKey: HourObject.kValueDefaultsKey))
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let otherHour = object as? HourObject else { return false }
//WARNING: Use Equatable?
        return otherHour.value == value
    }

}
