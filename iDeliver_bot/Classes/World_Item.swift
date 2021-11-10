//
//  World_Item.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import Foundation

class World_Item{
    
    private var x_:Float = 0
    private var y_:Float = 0
    private var z_:Float = 0
    
    init(_x:Float, _y:Float, _z:Float){
        self.x_ = _x
        self.y_ = _y
        self.z_ = _z
    }
    
    func getPos()->Array<Float>{
        return [self.x_, self.y_, self.z_]
    }
}
