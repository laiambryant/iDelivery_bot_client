//
//  Callback_Funcs.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 03/12/21.
//

import Foundation
import SocketIO

func login_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("LOGIN"){ data, ack in
            
        }
    }
}

func call_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
    sock_.on("CALL"){ data, ack in
            
        }
    }
}

func p_call_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("P_CALL"){ data, ack in
            
        }
    }
}

func arrived_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("ARRIVED"){ data, ack in
            
        }
    }
}

func obj_sent_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("OBJ_SENT"){ data, ack in
            
        }
    }
}

func obj_rcv_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("OBJ_RCV"){ data, ack in
            
        }
    }
}

func cancel_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("CANCEL"){ data, ack in
            
        }
    }
}

func timeout_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("TIMEOUT"){ data,ack in
            
        }
    }
}


func invalid_handler(sock_:SocketIOClient, req_type_str:String, body:String)->Void{
    sock_.emit(req_type_str, body){
        sock_.on("INVALID"){ data,ack in
            
        }
    }
}
