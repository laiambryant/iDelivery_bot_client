//
//  iDelivery_bot.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 23/11/21.
//

import Foundation

struct iDelivery_bot{
    
    private var _requests:Array<Request>
    public let _network_interface:Client_SIO
    private var _Connected:Bool = false
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
    
    func NI_connect(){
        _network_interface.connect_cl()
        
    }
    
    func NI_CALL(){
        let coords:Array<Float> = _bot.getPos()
        let msg:String = "{coordinates:{x:\(coords[0]),y:\(coords[1]),z:\(coords[2])},robot_id:10}"
        _network_interface.write_cl(data_:msg , req_type_: Request_Type.call)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
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
    
    mutating func isConnected_Toggle(){
        _Connected.toggle()
    }
    
    mutating func isBeingServed_Toggle(){
        _isBeingServed.toggle()
    }
    
    func isBeingServed()->Bool{
        return self._isBeingServed
    }
    
    func isConnected()->Bool{
        return self._Connected
    }
    func isLoggedIn()->Bool{
        return self._loginSuccess
    }
    
    mutating func NI_login(username_:String, password_:String)->Void{
        let msg = "{\"username\":\"\(username_)\", \"password\":\"\(password_)\"}"
        let ret:(String, Float, Float) = _network_interface.write_cl(data_: msg, req_type_: Request_Type.login) as! (String, Float, Float)
        // TODO: BASED ON RESPONSE DECIDE IF AUTH IS TRUE OR FALSE
        if(ret.0 == ""){
            _loginSuccess = false
        } else {
            _user = User(_name:ret.0, _x:ret.1, _y:ret.2, _z:0)
            _loginSuccess = true
        }
        
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
