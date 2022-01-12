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
        
        app.isBeingServed_Toggle()
    }
    
    func ni_isConnected()->Bool{
        return app.isConnected()
    }
    
    
    
    func ni_isBeingServed()->Bool{
        return app.isBeingServed()
    }
    
    func verify_credentials()->Bool{
        let username_:String =  app._user_data._username
        let password_:String = app._user_data._password
        app.NI_login(username_: username_, password_: password_)
        return app._user_data.auth
    }
    
}
