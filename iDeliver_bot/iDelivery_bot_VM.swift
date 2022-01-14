//
//  iDelivery_bot.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 23/11/21.
//

import SwiftUI
import Foundation

class iDelivery_bot_VM : ObservableObject{

    @Published var app:iDelivery_bot
    
    init(){
        app = iDelivery_bot()
    }
    
    // MARK: --Intent s(s)
    
    func ni_connect(){
        app.NI_connect()
        app.isConnected_Toggle()
    }
    
    func ni_call(){
        // Request
        app.NI_CALL()
        // Response
        app.isBeingServed_Toggle()
    }
    
    func ni_arrived(){
        // Request
        app.NI_ARRIVED()
        // Response
        
    }
    
    func ni_cancel(){
        //Request
        app.NI_CANCEL()
        //Response
    }
    
    func ni_rcv(){
        //Request
        app.NI_RCV()
        //Response
        
    }
    
    func drawOnImage(_ image: UIImage) -> UIImage {
         
         // Create a context of the starting image size and set it as the current one
         UIGraphicsBeginImageContext(image.size)
         
         // Draw the starting image in the current context as background
         image.draw(at: CGPoint.zero)

         // Get the current context
         let context = UIGraphicsGetCurrentContext()!

         // Draw a red line
         context.setLineWidth(2.0)
         context.setStrokeColor(UIColor.red.cgColor)
         context.move(to: CGPoint(x: 100, y: 100))
         context.addLine(to: CGPoint(x: 200, y: 200))
         context.strokePath()
         
         // Draw a transparent green Circle
         context.setStrokeColor(UIColor.green.cgColor)
         context.setAlpha(0.5)
         context.setLineWidth(10.0)
         context.addEllipse(in: CGRect(x: 100, y: 100, width: 100, height: 100))
         context.drawPath(using: .stroke) // or .fillStroke if need filling
         
         // Save the context as a new UIImage
        let myImage = UIGraphicsGetImageFromCurrentImageContext()!
         UIGraphicsEndImageContext()
         
         // Return modified image
         return myImage
    }
    
    func ni_isConnected()->Bool{
        return app.isConnected()
    }
    
    func ni_isBeingServed()->Bool{
        return app.isBeingServed()
    }
    
    func ni_isLoggedIn()->Bool{
        return app.isLoggedIn()
    }
    
    func verify_credentials()->Bool{
        let username_:String =  app._user_data._username
        let password_:String = app._user_data._password
        app.NI_login(username_: username_, password_: password_)
        return app._user_data.auth
    }
    
}
