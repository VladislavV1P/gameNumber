//
//  Game.swift
//  gameNumber
//
//  Created by Владислав Патраков on 13.02.2022.
//

import Foundation

enum StatusGame {
    case start
    case win
}

class Game {
    
    struct Item {
        var titel: String
        var isFound: Bool = false
    }
    
    
    private let data = Array(1...99)
    var items: [Item] = []
    private var countItems: Int
    var nextItem: Item?
    var status: StatusGame = .start
    
    init(countItems: Int) {
        self.countItems = countItems
        setupGame()
    }
     
    private func setupGame() {
        var digits = data.shuffled()
        
        while items.count < countItems {
            let item = Item(titel: String(digits.removeFirst()))
            items.append(item)
        }
        nextItem = items.shuffled().first
    }
    func check(index: Int) {
        
        if items[index].titel == nextItem?.titel  {
                items[index].isFound = true
            nextItem = items.shuffled().first(where: {$0.isFound == false})
            
        }
        if nextItem == nil {
            status = .win
        }
    }
}
