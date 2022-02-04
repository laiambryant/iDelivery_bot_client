//
//  iDelivery_bot.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 23/11/21.
//

import Foundation
import SwiftUI

struct iDelivery_bot{
    
    public var _network_interface:Client_SIO
    var _Connected:Bool = false
    private var _isBeingServed:Bool = false
    private var _loginSuccess:Bool = false
    private var _isAtLocation:Bool = false
    public var _aUserIsNotSelected:Bool = true
    public var _user:User
    public var _other_users:Array<User>
    private var _bot:Robot
    private var _req_no:Int
    public var _user_data:user_data
        
    init(){
        _user_data = user_data()
        _network_interface = Client_SIO()
        _user = User(_name: "", _x: 0.0, _y: 0.0, _z: 0.0)
        _bot = Robot(_ID: 0, _x: 49, _y: 11.77, _z: 0.0)
        _req_no = 0
        _other_users = Array<User>()
    }
    
    //MARK: --Network Interactions
    
    //Connects to network interface
    func NI_CONNECT(){
        _network_interface.connect_cl()
    }
    
    //Calls robot to user's position over network interface and dispatches an async event that will send a TIMEOUT request after 100 seconds
    func NI_CALL(){
        let coords:Array<Float> = _user.getPos()
        let msg:String = "{coordinates:{x:\(coords[0]),y:\(coords[1]),z:\(coords[2])},robot_id:10}"
        _network_interface.write_cl(data_:msg , req_type_: Request_Type.call)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 100) {
            let tout_msg:String = "{robot_id:11}"
            _network_interface.write_cl(data_:tout_msg , req_type_: Request_Type.timeout)
        }
    }
    
    //Sends ARRIVED message over network interface
    func NI_SEND(){
        var user_pos:Array<Float> = [0.0,0.0]
        for u in _other_users {
            if(u.is_selected()){
                user_pos = u.getPos()
            }
        }
        let msg:String = "{coordinates:{x:\(user_pos[0]),y:\(user_pos[1]),z:0.0)},robot_id:10}"
        _network_interface.write_cl(data_:msg , req_type_: Request_Type.send)
    }
    
    //Sends CANCEL message over network interface
    func NI_CANCEL(){
        let msg:String = "{robot_id:10}"
        _network_interface.write_cl(data_:msg , req_type_: Request_Type.cancel)
    }
    
    //Sends ARRIVED message over network interface
    func NI_RCV(){
        let msg:String = "{robot_id:10}"
        _network_interface.write_cl(data_:msg , req_type_: Request_Type.obj_recieved)
    }
    
    //Sends Disconnect message over network interface and resets all significant variables
    mutating func NI_DISCONNECT(){
        _user = User(_name: "", _x: 0.0, _y: 0.0, _z: 0.0)
        _other_users = Array<User>()
        _user_data = user_data()
        _network_interface = Client_SIO()
        _network_interface.disconnect_cl()
    }
    
    //Sends login request over network interface
    mutating func NI_LOGIN(username_:String, password_:String)->Void{
        let msg = "{\"username\":\"\(username_)\", \"password\":\"\(password_)\"}"
        _network_interface.write_cl(data_: msg, req_type_: Request_Type.login)        
    }
    
    //MARK: --Mutating Toggles
    
    mutating func isConnected_Toggle(){
        _Connected.toggle()
    }
    mutating func isBeingServed_Toggle(){
        _isBeingServed.toggle()
    }
    mutating func isLoggedIn_Toggle(){
        _loginSuccess.toggle()
    }
    
    mutating func isAtLocation_Toggle(){
        _isAtLocation.toggle()
    }
    
    mutating func aUserIsSelected_Toggle(){
        self._aUserIsNotSelected.toggle()
    }
    
    mutating func add_user(new_user:User){
        self._other_users.append(new_user)
    }
    
    
    //MARK: --Mutating Funcs
    
    mutating func update_pos( new_x:Float, new_y: Float, new_z: Float){
        self._user.updatePos(_x:new_x, _y: new_y, _z:new_z )
    }
    
    mutating func bot_update_pos(new_x:Float, new_y: Float, new_z: Float){
        self._bot.updatePos(_x: new_x, _y: new_y, _z: new_z)
    }
    
    mutating func user_select(user:User){
        var previous:User = User(_name: "default", _x: 0.0, _y: 0.0, _z: 0.0)
        for u in _other_users {
            if(u.is_selected()){
                previous = u
                u.selected = false
                aUserIsSelected_Toggle()
            }
        }
        if(user.name_ != previous.name_){
            user.selected = true
            aUserIsSelected_Toggle()
        }
    }
    
    //MARK: --Getters
    
    func isBeingServed()->Bool{
        return self._isBeingServed
    }
    
    func isAtLocation()->Bool{
        return self._isAtLocation
    }
    
    func isConnected()->Bool{
        return self._Connected
    }
    
    func isLoggedIn()->Bool{
        return self._loginSuccess
    }
    
    func getBot()->Robot{return _bot}
    
    
}


//MARK: --User Data

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
