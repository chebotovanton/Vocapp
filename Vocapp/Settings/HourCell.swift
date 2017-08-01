import UIKit

class HourCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!

    func setup(_ hour: HourObject) {
        label.text = String(hour.value)
        label.alpha = 0.2
    }

    override var isSelected: Bool {
        didSet {
            let newAlpha: CGFloat
            let newFont: UIFont
            if isSelected {
                newAlpha = 1.0
                newFont = UIFont.systemFont(ofSize: 80, weight: UIFontWeightMedium)
            } else {
                newAlpha = 0.2
                newFont = UIFont.systemFont(ofSize: 80, weight: UIFontWeightLight)
            }
            UIView.animate(withDuration: 0.3) {
                self.label.font = newFont
                self.label.alpha = newAlpha
            }
        }
    }

}
