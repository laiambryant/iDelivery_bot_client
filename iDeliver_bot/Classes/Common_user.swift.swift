//
//  Common_user.swift.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import Foundation

class Common_user:User{
    override init(_x: Float, _y: Float, _z: Float) {
        super.init(_x:_x,_y:_y,_z:_z)
        self.priority = 0
    }
}