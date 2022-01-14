//
//  Drawing.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 14/01/22.
//

import Foundation
import UIKit
import SwiftUI

func draw_user( x_:Int, y_:Int, color:UIColor){
    
    let context = UIGraphicsGetCurrentContext()!
    
    context.setStrokeColor(color.cgColor)
    context.setAlpha(0.5)
    context.setLineWidth(10.0)
    context.addEllipse(in: CGRect(x:x_, y: y_, width: 100, height: 100))
    context.drawPath(using: .stroke) // or .fillStroke if need filling
    
}

func draw_robot(bot:Robot){
    let robot = UIImage(named:"Robot")
    robot?.draw(in: .init(x:Int(bot.getPos()[0]), y:Int(bot.getPos()[1]), width: 160, height: 90))
}
