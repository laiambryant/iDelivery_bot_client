//
//  iDelivery_bot.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 23/11/21.
//

import Foundation
import SwiftUI

struct iDelivery_bot{
    
    private var _requests:Array<Request>
    public let _network_interface:Client_SIO
    var _Connected:Bool = false
    private var _isBeingServed:Bool = false
    private var _loginSuccess:Bool = false
    public var _user:User
    public var _other_users:Array<User>
    private var _bot:Robot
    private var _req_no:Int
    public var _user_data:user_data
        
    init(){
        _user_data = user_data()
        _requests = Array<Request>()
        _network_interface = Client_SIO()
        _user = User(_name: "", _x: 0.0, _y: 0.0, _z: 0.0)
        _bot = Robot(_ID: 0, _x: 900, _y: 700, _z: 0.0)
        _req_no = 0
        _other_users = Array<User>()
    }
    
    func NI_CONNECT(){
        _network_interface.connect_cl()
        
    }
    
    func NI_CALL(){
        let coords:Array<Float> = _bot.getPos()
        let msg:String = "{coordinates:{x:\(coords[0]),y:\(coords[1]),z:\(coords[2])},robot_id:10}"
        _network_interface.write_cl(data_:msg , req_type_: Request_Type.call)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 100) {
            let tout_msg:String = "{robot_id:11}"
            _network_interface.write_cl(data_:tout_msg , req_type_: Request_Type.timeout)
        }
    }
    
    func NI_ARRIVED(){
        let coords:Array<Float> = _bot.getPos()
        let msg:String = "{coordinates:{x:\(coords[0]),y:\(coords[1]),z:\(coords[2])},robot_id:10}"
        _network_interface.write_cl(data_:msg , req_type_: Request_Type.arrived)
    }
    
    func NI_CANCEL(){
        let msg:String = "{robot_id:10}"
        _network_interface.write_cl(data_:msg , req_type_: Request_Type.cancel)
    }
    
    func NI_RCV(){
        let msg:String = "{robot_id:10}"
        _network_interface.write_cl(data_:msg , req_type_: Request_Type.obj_recieved)
    }
    
    mutating func NI_LOGIN(username_:String, password_:String)->Void{
        let msg = "{\"username\":\"\(username_)\", \"password\":\"\(password_)\"}"
        _network_interface.write_cl(data_: msg, req_type_: Request_Type.login)        
    }
    
    // Mutating Toggles
    
    mutating func isConnected_Toggle(){
        _Connected.toggle()
    }
    mutating func isBeingServed_Toggle(){
        _isBeingServed.toggle()
    }
    mutating func isLoggedIn_Toggle(){
        _loginSuccess.toggle()
    }
    
    mutating func add_user(new_user:User){
        self._other_users.append(new_user)
    }
    
    // Getters
    
    func isBeingServed()->Bool{
        return self._isBeingServed
    }
    
    func isConnected()->Bool{
        return self._Connected
    }
    
    func isLoggedIn()->Bool{
        return self._loginSuccess
    }
    
    func getBot()->Robot{return _bot}
    
    struct user_data{
        var _username:String
        var _password:String
        var auth:Bool
        init(){
            _username = ""
            _password = ""
            auth = false
        }
        init(username_:String, password_:String){
            _username = username_
            _password = password_
            auth = false
        }
    }
}
