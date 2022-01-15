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
        app.NI_CONNECT()
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
    
    func ni_isConnected()->Bool{
        return app.isConnected()
    }
    
    func ni_isBeingServed()->Bool{
        return app.isBeingServed()
    }
    
    func ni_isLoggedIn()->Bool{
        return app.isLoggedIn()
    }
    
    func verify_credentials()->Void{
        let username_:String =  app._user_data._username
        let password_:String = app._user_data._password
        app.NI_LOGIN(username_: username_, password_: password_)
        app.isLoggedIn_Toggle()
        get_users()
    }
    
    func get_users(){
        var username:String = ""
        var x:Float = 0
        var y:Float = 0
        
        app._network_interface._sock.on("USERS"){ data, ack in
        
            let arr = data[0] as! Array<NSMutableDictionary>
            for elem in arr{
                username = elem.value(forKey: "username")as! String
                x = elem.value(forKey: "x_pos") as! Float
                y = elem.value(forKey: "y_pos") as! Float
                if(username != self.app._user.name_){
                    self.app.add_user(new_user:User(_name: username, _x: x, _y: y, _z: 0.0))
                }
            }
        }
    }
    
}
