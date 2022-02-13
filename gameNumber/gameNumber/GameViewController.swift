//
//  GameViewController.swift
//  gameNumber
//
//  Created by Владислав Патраков on 12.02.2022.
//

import UIKit

class GameViewController: UIViewController {

     
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
       
    }
    

    @IBAction func pressButton(_ sender: UIButton) {
        sender.isHidden = true
        print(sender.tag)
    }
    

}
