//
//  iDelivery_bot.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 23/11/21.
//

import SwiftUI
import Foundation

class iDelivery_bot : ObservableObject{
    
    private var _requests:Array<Request>
    private let _network_interface:Client_SIO
    @Published var isConnected:Bool = false
    private var _map:Map
    private var _user:User
    private var _bot:Robot
    var _user_data:user_data
    
    init(){
        _user_data = user_data()
        _requests = Array<Request>()
        _network_interface = Client_SIO()
        _map = Map()
        _user = User(_name: "", _x: 0.0, _y: 0.0, _z: 0.0)
        _bot = Robot(_ID: 0, _x: 0.0, _y: 0.0, _z: 0.0)
    }
    
    func ni_connect(){
        _network_interface.connect_cl()
        isConnected.toggle()
    }
    
    func ni_login(){
        
    }
    
    func ni_setPosition(){
        
    }
    
    func setRobot(){
        
    }
    
    func setMap(){
        
    }
    
    func setUser(){
        
    }
    
    struct user_data{
        var _username:String
        var _password:String
        init(){
            _username = ""
            _password = ""
        }
    }
    
}
