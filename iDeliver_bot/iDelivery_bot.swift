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
    private var _map:Map
    private var _user:User
    private var _bot:Robot
    private var _req_no:Int
    public var _user_data:user_data
    
    
    init(){
        _user_data = user_data()
        _requests = Array<Request>()
        _network_interface = Client_SIO()
        _map = Map()
        _user = User(_name: "", _x: 0.0, _y: 0.0, _z: 0.0)
        _bot = Robot(_ID: 0, _x: 0.0, _y: 0.0, _z: 0.0)
        _req_no = 0
    }
    
    func NI_connect(){
        _network_interface.connect_cl()
        
    }
    
    func NI_CALL(){
        _network_interface.write_cl(data_:"" , req_type_: Request_Type.call)
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
    
    mutating func NI_login(username_:String, password_:String)->Void{
        let msg = "{username:\(username_), password:\(password_)}"
        _network_interface.write_cl(data_: msg, req_type_: Request_Type.login)
        let ret:String = _network_interface.read_cl()
        print (ret)
        // TODO: BASED ON RESPONSE DECIDE IF AUTH IS TRUE OR FALSE
        _user_data.auth = true
    }
    
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
