import UIKit

class ViewController: UIViewController {
    private var storageKey = GameViewController().storageKey
    private var recorderList = [0, 0, 0]

    @IBOutlet weak var resultLabel: UILabel!

    private func tableRating() {
        resultLabel.text = """
        First place: \(recorderList[0])
        Second place: \(recorderList[1])
        Third place: \(recorderList[2])
        """
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recorderList = UserDefaults.standard.array(forKey: storageKey) as? [Int] ?? [0, 0, 0]
        tableRating()
    }
}
