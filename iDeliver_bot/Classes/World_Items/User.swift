//
//  User.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import Foundation

class User:World_Item{
    public var exists:Bool
    public var selected:Bool = false
    override init(_name:String, _x: Float, _y: Float, _z: Float) {
        self.exists = false;
        super.init(_name: _name, _x: _x, _y: _y, _z: _z)
    }
    func user_exists()->Void{
        exists = true;
    }
    func is_selected()->Bool{
        return selected
    }
}
