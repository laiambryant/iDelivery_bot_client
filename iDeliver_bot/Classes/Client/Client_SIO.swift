//
//  Client.swift.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 12/11/21.
//

import Foundation
import CoreText
import SocketIO
import SwiftUI

class Client_SIO{
    
    private var _sock:SocketIOClient
    private var _cli_status:Client_Status
    private var _buffer:[Character] = []
    private let _port:UInt16 = 9000
    private let _manager:SocketManager
    private let _requests_str:[String] = [
        "login", "call", "priority_call", "arrived",
        "obj_sent", "obj_recieved", "cancel", "timeout"
    ]
    private let _localhost_str = "http://localhost:"
    init() {
        let addr:String = _localhost_str + String(_port)
        _manager = SocketManager(socketURL: URL(string: addr)!, config: [.log(true), .compress])
        _sock = _manager.defaultSocket
        _cli_status = Client_Status.waiting
    }
    
    func connect_cl()->Void{
        _sock.connect()
        _sock.on(clientEvent: .connect){
            (data, ack) in
            print(data)
            self._cli_status = Client_Status.waiting
        }
        _sock.on(clientEvent: .error){
            (data, ack) in
            print(data)
        }
    }
    func read_cl()->Void{
        self._cli_status = Client_Status.reading
        
        //Write requests possible reads here
        _sock.on(""){
            (data, ack) in
        
        }
        
        self._cli_status = Client_Status.waiting
    }
    func write_cl(data_:String, req_type_:Request_Type)->Void{
        self._cli_status = Client_Status.reading
        print("Called write func")
        switch req_type_ {
        case .login:
            _sock.emit("LOGIN", data_)
        case .call:
            _sock.emit("CALL", data_)
        case .priority_call:
            _sock.emit("PRIORITY_CALL", data_)
        case .arrived:
            _sock.emit("ARRIVED", data_)
        case .obj_sent:
            _sock.emit("OBJ_SENT", data_)
        case .obj_recieved:
            _sock.emit("OBJ_RCV", data_)
        case .cancel:
            _sock.emit("CANCEL", data_)
        case .timeout:
            _sock.emit("TIMEOUT", data_)
        }
        
        self._cli_status = Client_Status.waiting
    }
   
}

func connect_cl(){
    let cli:Client_SIO = Client_SIO()
    cli.connect_cl()
}



