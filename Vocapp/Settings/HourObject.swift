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

    public static func ==(lhs: HourObject, rhs: HourObject) -> Bool {
        return lhs.value == rhs.value
    }

}
