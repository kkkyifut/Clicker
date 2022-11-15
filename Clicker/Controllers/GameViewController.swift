import UIKit

class GameViewController: UIViewController {
    private var timer: Timer?
    private var timeLeft = 20.0
    private var counter = 0
    private var recorderList = [0, 0, 0]
    private var storage = UserDefaults.standard
    var storageKey = "records"

    @IBOutlet private var countLabel: UILabel!
    @IBOutlet private var timerLabel: UILabel!
    @IBOutlet private var recordFirst: UILabel!
    @IBOutlet private var recordSecond: UILabel!
    @IBOutlet private var recordThird: UILabel!

    @IBAction private func clickButton(_ sender: UIButton) {
        counter += 1
        countLabel.text = "\(counter)"
        if timeLeft == 20.0 {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(onTimeFires), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func onTimeFires() {
        timeLeft -= 0.01
        timerLabel.text = "\(round(timeLeft * 100) / 100.0)"
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            timerLabel.text = "0.00"
            timeLeft = 20.0
            recorder()
        }
    }
    
    private func recorder() {
        for i in 0..<recorderList.count {
            if recorderList[i] < counter {
                recorderList.insert(counter, at: i)
                recorderList.remove(at: recorderList.count - 1)
                break
            }
        }
        
        storage.set(recorderList, forKey: storageKey)
        let recordFirstCount = recorderList[0]
        let recordSecondCount = recorderList[1]
        let recordThirdCount = recorderList[2]
                
        if recordFirstCount <= 0 {
            recordFirst.text = ""
        } else {
            recordFirst.text = "First place: \(recordFirstCount)"
        }
        if recordSecondCount <= 0 {
            recordSecond.text = ""
        } else {
            recordSecond.text = "Second place: \(recordSecondCount)"
        }
        if recordThirdCount <= 0 {
            recordThird.text = ""
        } else {
            recordThird.text = "Third place: \(recordThirdCount)"
        }
        counter = 0
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        recorderList = storage.array(forKey: storageKey) as? [Int] ?? [0, 0, 0]
        recorder()
    }
}
