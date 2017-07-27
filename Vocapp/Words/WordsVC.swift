import UIKit

private let reuseIdentifier = "Cell"
private let headerIdentifier = "Header"

class WordsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NotificationManagerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var calculationCell: WordExampleCell!
    var sections: [Section] = []
    let kLineSpacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calculationCell = loadCalculationCell()
        collectionView.alwaysBounceVertical = true

        collectionView.register(UINib(nibName: "WordExampleCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(UINib(nibName: "WordTableHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView?.collectionViewLayout = layout

        if DefaultsManager.isFirstLaunch() {
            firstLaunchProcess()
        } else {
            sections = createSections()
        }
    }

    func loadCalculationCell() -> WordExampleCell {
        let nibViews = Bundle.main.loadNibNamed("WordExampleCell", owner: nil, options: nil)
        return nibViews![0] as! WordExampleCell
    }

    func createSections() -> [Section] {
        var days = WordsLoader.shared.wordsSeenByUser()

        var result: [Section] = []
        for i in 0..<days.count {
            let day = days[i]
            let section = Section(title: day.title(), examples: day.words)
            result.append(section)
        }

        return result.reversed()
    }

    private func updateTopInset() {
        UIView.animate(withDuration: 0.3) { 
            var topInset = self.collectionView.frame.height - self.collectionView.contentSize.height - self.kLineSpacing
            topInset = max(0, topInset)
            self.collectionView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        }
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

    //MARK: - First Launch Process

    private func firstLaunchProcess() {
        sections = [Section(title: "Greetings, stranger!", examples: [firstGreetingWord()])]
        collectionView.reloadData()
        updateTopInset()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showSecondWord()
        }
    }

    private func showSecondWord() {
        sections = [Section(title: "Greetings, stranger!", examples: [firstGreetingWord(), secondGreetingWord()])]
        updateTopInset()
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: [IndexPath(item: 1, section: 0)])
        }, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            NotificationsManager.shared.delegate = self
            NotificationsManager.shared.authorize()
        }
    }

    private func showThirdWord() {
        sections = [Section(title: "Greetings, stranger!", examples: [firstGreetingWord(), secondGreetingWord(), thirdGreetingWord()])]
        updateTopInset()
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: [IndexPath(item: 2, section: 0)])
        }, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showFourthWord()
        }
    }

    private func showFourthWord() {
        sections = [Section(title: "Greetings, stranger!", examples: [firstGreetingWord(), secondGreetingWord(), thirdGreetingWord(), fourthGreetingWord()])]
        collectionView.performBatchUpdates({
            self.collectionView.insertItems(at: [IndexPath(item: 3, section: 0)])
        }, completion: nil)
        updateTopInset()
    }

    private func firstGreetingWord() -> WordExample {
        return WordExample(text: "Hey, it's time to make notifications useful", translation: "Эй, пора сделать пуши полезными")
    }

    private func secondGreetingWord() -> WordExample {
        return WordExample(text: "First, let us send you notifications", translation: "Для начала, разреши отправлять тебе уведомления")
    }

    private func thirdGreetingWord() -> WordExample {
        return WordExample(text: "Fine.\nNow set the words arriving period using settings tab", translation: "Отлично.\nТеперь выстави в настройках удобный период для получения новых слов")
    }

    private func fourthGreetingWord() -> WordExample {
        let hours = NotificationsManager.shared.hoursToFirstNotification()
        let hoursString = String(hours)
        let text = "Relax. The next word is a-coming in about " + hoursString + " hours"
        let translation = "Расслабьтесь. Первое слово придет примерно через " + hoursString + " часов"
        return WordExample(text: text, translation: translation)
    }


    //MARK: - NotificationManagerDelegate

    func notificationAccessGranted(_ granted: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showThirdWord()
        }
    }
}
