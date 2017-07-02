//
//  SettingsVC.swift
//  Vocapp
//
//  Created by Aviasales on 27/06/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SettingsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var fromCollectionView: UICollectionView!
    @IBOutlet weak var toCollectionView: UICollectionView!

    let fromHours: [HourObject] = [HourObject(9), HourObject(10), HourObject(11), HourObject(12)]
    let toHours: [HourObject] = [HourObject(21), HourObject(22), HourObject(23)]




    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "HourCell", bundle: nil)
        fromCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        toCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        fromCollectionView.collectionViewLayout = layout()
        toCollectionView.collectionViewLayout = layout()
    }

    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal

        return layout
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == fromCollectionView {
            return fromHours.count
        } else {
            return toHours.count
        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HourCell

        let hour: HourObject
        if collectionView == fromCollectionView {
            hour = fromHours[indexPath.item]
        } else {
            hour = toHours[indexPath.item]
        }

        cell.setup(hour)

        return cell
    }


}
