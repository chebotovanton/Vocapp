//
//  SettingsVC.swift
//  Vocapp
//
//  Created by Aviasales on 27/06/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SettingsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var fromCollectionView: UICollectionView!
    @IBOutlet weak var toCollectionView: UICollectionView!

    let fromHours: [HourObject] = [HourObject(7), HourObject(8), HourObject(9), HourObject(10), HourObject(11), HourObject(12)]
    let toHours: [HourObject] = [HourObject(18), HourObject(19), HourObject(20), HourObject(21), HourObject(22), HourObject(23)]

    var calculationCell: HourCell!

    override func viewDidLoad() {
        super.viewDidLoad()

        calculationCell = loadCalculationCell()

        let nib = UINib(nibName: "HourCell", bundle: nil)
        fromCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        toCollectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        fromCollectionView.collectionViewLayout = layout()
        toCollectionView.collectionViewLayout = layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //WARNING: What's the item?

        if let firstIndex = fromHours.index(of: DefaultsManager.firstHour()) {
            fromCollectionView.selectItem(at: IndexPath(item: firstIndex, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
        if let lastIndex = toHours.index(of: DefaultsManager.lastHour()) {
            toCollectionView.selectItem(at: IndexPath(item: lastIndex, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
    }

    func loadCalculationCell() -> HourCell {
        let nibViews = Bundle.main.loadNibNamed("HourCell", owner: nil, options: nil)
        return nibViews![0] as! HourCell
    }

    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let hour: HourObject
        if collectionView == fromCollectionView {
            hour = fromHours[indexPath.item]
        } else {
            hour = toHours[indexPath.item]
        }

        calculationCell.setup(hour)
        calculationCell.isSelected = true
        let targetSize = CGSize(width: 100, height: 100)
        let size = calculationCell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority:UILayoutPriorityFittingSizeLevel, verticalFittingPriority: UILayoutPriorityRequired)

        return size
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        var firstHour = DefaultsManager.firstHour()
        var lastHour = DefaultsManager.lastHour()

        if collectionView == fromCollectionView {
            firstHour = fromHours[indexPath.item]
            DefaultsManager.saveFirstHour(firstHour)
        } else {
            lastHour = toHours[indexPath.item]
            DefaultsManager.saveLastHour(lastHour)
        }
        NotificationsManager.shared.setScheduledNotifications(firstHour, last: lastHour)
    }

}
