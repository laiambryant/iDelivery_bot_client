//
//  Callback_Funcs.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 03/12/21.
//

import Foundation
import SocketIO

func login_handler(sock_:SocketIOClient, req_type_str:String, body:String){
    var username:String = ""
    var x:Float = 0
    var y:Float = 0
    var ret:Array<User> = Array<User>()
    
    sock_.emit(req_type_str, body){
        
        sock_.on("LOGIN_SUCCESS"){ data, ack in
            
            username = data[0] as! String //Username
            x = data[1] as! Float //x_pos
            y = data[2] as! Float//y_pos
            ret.append(User(_name: username, _x: x, _y: y, _z: 0.0))
            
        }
        
        sock_.on("LOGIN_FAILURE"){ data, ack in
            print(data)
        }
        
    }
    
}

func call_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
    sock_.on("CALL"){ data, ack in
            print(data)
        }
    }
}

func p_call_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("P_CALL"){ data, ack in
            print(data)
        }
    }
}

func arrived_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("ARRIVED"){ data, ack in
            print(data)
        }
    }
}

func obj_sent_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("OBJ_SENT"){ data, ack in
            print(data)
        }
    }
}

func obj_rcv_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("OBJ_RCV"){ data, ack in
            print(data)
        }
    }
}

func cancel_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("CANCEL"){ data, ack in
            print(data)
        }
    }
}

func timeout_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("TIMEOUT"){ data,ack in
            print(data)
        }
    }
}


func invalid_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("INVALID"){ data,ack in
            print(data)
        }
    }
}
