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
    
    
    lazy var game = Game(countItems: buttonCollection.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
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
        for index in game.items.indices {
            buttonCollection[index].setTitle(game.items[index].titel, for: .normal)
            buttonCollection[index].isHidden = false
        }
        nextDigit.text = game.nextItem?.titel
    }
    private func updateIU() {
        for index in game.items.indices {
            buttonCollection[index].isHidden = game.items[index].isFound
        }
        nextDigit.text = game.nextItem?.titel
        if game.status == .win {
            statusGameLabel.text = "Вы победили"
        }
    }

}
