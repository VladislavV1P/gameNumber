//
//  GameViewController.swift
//  gameNumber
//
//  Created by Владислав Патраков on 12.02.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var buttonCollection: [UIButton]!

    @IBOutlet weak var statusGameLabel: UILabel!
    @IBOutlet weak var  nextDigit: UILabel!
    @IBOutlet weak var tamerLabel: UILabel!
    
    
    @IBOutlet weak var refreshButton: UIButton!
    
    
    lazy var game = Game(countItems: buttonCollection.count, time:  30) { [weak self] (status, time) in
        guard let self =  self else {return}
        self.tamerLabel.text = time.secondsToString()
        self.updateStatusGame(status: status)
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
         
            setupScreen()
       
    }
    

    @IBAction func refreshButtonNew(_ sender: UIButton) {
        game.newGame()
        setupScreen()
 
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttonCollection.firstIndex(of: sender) else {
            return
        }
        game.check(index: buttonIndex)
        updateIU()
    }
    
    private func setupScreen() {
        refreshButton.isHidden = true
        for index in game.items.indices {
            buttonCollection[index].setTitle(game.items[index].titel, for: .normal)

            buttonCollection[index].alpha = 1
            buttonCollection[index].isEnabled = true
        }
        nextDigit.text = game.nextItem?.titel
    }
    private func updateIU() {
        for index in game.items.indices {

            buttonCollection[index].alpha = game.items[index].isFound ? 0 : 1
            buttonCollection[index].isEnabled = !game.items[index].isFound
            if game.items[index].isErrors {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttonCollection[index].backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
                } completion: { [weak self] (_) in
                    self?.buttonCollection[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    self?.game.items[index].isErrors = false
                }

            }
        }
        nextDigit.text = game.nextItem?.titel
        
        updateStatusGame(status: game.status)
    }
    
    private func updateStatusGame(status: StatusGame) {
        switch status {
        case .start:
            statusGameLabel.text = "Игра началась"
            statusGameLabel.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case  .win:
            statusGameLabel.text = "Вы выиграли"
            statusGameLabel.textColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            refreshButton.isHidden = false
        case .lose:
            statusGameLabel.text = "Вы проиграли"
            statusGameLabel.textColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            refreshButton.isHidden = false
        }
    }

}

extension Int {
    func secondsToString() -> String {
        let minute = self / 60
        let second = self % 60
        return String(format: "%d:%02d", minute,second )
    }
}
