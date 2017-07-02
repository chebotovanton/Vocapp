//
//  WordsVC.swift
//  Vocapp
//
//  Created by Aviasales on 27/06/2017.
//  Copyright © 2017 vocapp. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let headerIdentifier = "Header"

class WordsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var calculationCell: WordExampleCell!

    var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calculationCell = loadCalculationCell()
        collectionView.alwaysBounceVertical = true

        sections = createSections()
        collectionView.register(UINib(nibName: "WordExampleCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(UINib(nibName: "WordTableHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView?.collectionViewLayout = layout
    }

    func loadCalculationCell() -> WordExampleCell {
        let nibViews = Bundle.main.loadNibNamed("WordExampleCell", owner: nil, options: nil)
        return nibViews![0] as! WordExampleCell
    }

    func createSections() -> [Section] {
        let words = WordsLoader.shared.loadWords()
        var result: [Section] = []
        for i in 0..<words.count {
            let dayWords = words[i]
            let title = "DAY " + String(i + 1)
            let section = Section(title: title, examples: dayWords)
            result.append(section)
        }

        return result
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].examples.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WordExampleCell

        let example = sections[indexPath.section].examples[indexPath.item]
        cell.setup(example)
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let example = sections[indexPath.section].examples[indexPath.item]
        calculationCell.setup(example)
        let targetSize = CGSize(width: collectionView.frame.width, height: 1000)
        let size = calculationCell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriorityRequired, verticalFittingPriority: UILayoutPriorityFittingSizeLevel)

        return size
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! WordTableHeader
        let section = sections[indexPath.section]
        header.setupWithTitle(title: section.title)

        return header
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
