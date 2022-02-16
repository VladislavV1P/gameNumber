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
    case lose
}

class Game {
    
    struct Item {
        var titel: String
        var isFound: Bool = false
        var isErrors = false
    }
    
    
    private let data = Array(1...99)
    var items: [Item] = []
    private var countItems: Int
    var nextItem: Item?
    
    var status: StatusGame = .start {
        didSet {
            if status != .start {
                stopGame()
            }
        }
    }

    private var timeForGame: Int {
        didSet {
            if timeForGame == 0 {
                status = .lose
            }
            updateTimer(status, timeForGame )
        }
    }
    private var startTime: Int
    
    private var timer: Timer?
    
    private var updateTimer:((StatusGame,Int) -> Void)
    
    init(countItems: Int, time: Int, updateTimer:@escaping (_ status: StatusGame, _ second: Int) -> Void) {
        self.countItems = countItems
        self.timeForGame = time
        self.startTime = time
        self.updateTimer = updateTimer
        setupGame()
    }
     
    private func setupGame() {
        items.removeAll()
        var digits = data.shuffled()
        
        while items.count < countItems {
            let item = Item(titel: String(digits.removeFirst()))
            items.append(item)
        }
         
        nextItem = items.shuffled().first
        
        updateTimer(status, timeForGame)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self]
            (_) in
            self?.timeForGame -= 1
        })
    }
    
    func newGame() {
        status = .start
        self.timeForGame = self.startTime
        setupGame()
    }
    
    
    func check(index: Int) {
        guard status == .start else {return }
        if items[index].titel == nextItem?.titel  {
                items[index].isFound = true
            nextItem = items.shuffled().first(where: {$0.isFound == false})
            
        } else {
            items[index].isErrors  = true
        }
        if nextItem == nil {
            status = .win
        }
    }
    
    private func stopGame() {
        timer?.invalidate()
    }
}
