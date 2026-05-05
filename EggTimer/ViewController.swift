import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var labelText: UILabel!
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var secondsRemaining = 0
    var totalTime = 0   // ✅ total time store
    var timer: Timer?

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // Stop previous timer
        timer?.invalidate()
        
        guard let hardness = sender.currentTitle,
              let time = eggTimes[hardness] else {
            return
        }
        
        labelText.text = hardness
        
        totalTime = time              // ✅ set total time
        secondsRemaining = time
        
        progressBar.progress = 0.0    // ✅ reset progress
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateCountdown),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func updateCountdown() {
        
        if secondsRemaining > 0 {
            
            secondsRemaining -= 1
            
            // ✅ Calculate progress
            let progress = Float(totalTime - secondsRemaining) / Float(totalTime)
            progressBar.progress = progress
            
            print("\(secondsRemaining) seconds")
            
        } else {
            timer?.invalidate()
            timer = nil
            progressBar.progress = 1.0  // ✅ full
            
            labelText.text = "Done"
            
            print("Done!")
        }
    }
}
