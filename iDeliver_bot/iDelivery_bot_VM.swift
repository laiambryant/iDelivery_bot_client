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
    
    // MARK: --Ctors
    
    //Initializes app
    init(){
        app = iDelivery_bot()
    }
    
// MARK: --Getters
    
    func ni_isConnected()->Bool{
        return app.isConnected()
    }
    
    func ni_isBeingServed()->Bool{
        return app.isBeingServed()
    }
    
    func ni_isAtLocation()->Bool{
        return app.isAtLocation()
    }
    
    func ni_isLoggedIn()->Bool{
        return app.isLoggedIn()
    }
    
    // MARK: --Intent s(s)
    
    //Connects to server on network interface
    func ni_connect(){
        app.NI_CONNECT()
        app.isConnected_Toggle()
    }
    
    //Disconnects from server on network interface
    func ni_disconnect(){
        app.NI_DISCONNECT()
        app.isLoggedIn_Toggle()
        app.isConnected_Toggle()
    }
    
    //Calls bot over network interface
    func ni_call(){
        // Request
        app.NI_CALL()
        // Response
        app.isBeingServed_Toggle()
    }
    
    //Sends a SEND message over network interface
    func ni_send(){
        // Request
        app.NI_SEND()
        // Response
    }
    
    //Sends a CANCEL message over network interface
    func ni_cancel(){
        //Request
        app.NI_CANCEL()
        //Response
    }
    
    //Sends a RCV message over network interface
    func ni_rcv(){
        //Request
        app.NI_RCV()
        //Response
        update_robot_position()
    }
    
    // Verifies credentials and activates Disconnect handler
    func verify_credentials()->Void{
        let username_:String =  app._user_data._username
        let password_:String = app._user_data._password
        app.NI_LOGIN(username_: username_, password_: password_)
        app.isLoggedIn_Toggle()
        app._network_interface._sock.on("Disconnect"){ data, ack in
            self.app.isLoggedIn_Toggle()
            self.ni_disconnect()
        }
        get_users()
    }
    
    // MARK: --Other
    
    func update_robot_position(){
        
        app._network_interface._sock.on("ROBO_POS"){ data, ack in
            var x:Float = 0
            var y:Float = 0
            let arr = data[0] as! Array<NSMutableDictionary>
            for elem in arr{
                x = elem.value(forKey: "x_pos") as! Float
                y = elem.value(forKey: "y_pos") as! Float
            }
            self.app.bot_update_pos(new_x: x, new_y: y, new_z: 0.0)
        }
        
    }
    
    //Gets users from network and adds them to model
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
                if(username != self.app._user_data._username){
                    print(username + "!=" + self.app._user.name_)
                    self.app.add_user(new_user:User(_name: username, _x: x, _y: y, _z: 0.0))
                }else{
                    self.app.update_pos(new_x: x, new_y: y, new_z: 0.0)
                }
            }
        }
    }
    
    func select_user(user_:User){
        app.user_select(user: user_)
    }
    
}
