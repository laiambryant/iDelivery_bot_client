//
//  Admin.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import Foundation

class Admin:User{
    private let priority:Int = 1
    override init(_name:String, _x: Float, _y: Float, _z: Float) {
        super.init(_name: _name, _x: _x, _y: _y, _z: _z)
    }
}
