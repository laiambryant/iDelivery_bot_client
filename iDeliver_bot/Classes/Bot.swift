//
//  Bot.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import Foundation

class Robot:World_Item{
   
    private var active:Bool = false
    private let ID_:Int
   
    init(_ID:Int, _x: Float, _y: Float, _z: Float) {
        self.ID_ = _ID
        self.active = true
        super.init(_x: _x, _y: _y, _z: _z)
    }
  
    func deactivate(){
        self.active = false
    }

}
