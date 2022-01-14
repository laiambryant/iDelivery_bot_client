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
    private let _port:UInt16 = 5050
    private let _manager:SocketManager
    private let _requests_str:[String] = [
        "login", "call", "priority_call", "arrived",
        "obj_sent", "obj_recieved", "cancel", "timeout"
    ]
    //localhost string used if server is on the same machine, ip addr if server is on another machine
    private let _localhost_str = "http://localhost:"
    private let _ip_addr = "http://192.168.1.64:"
    private let _docker_container_ip_addr = "http://172.17.0.1"
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
        _sock.on(clientEvent: .disconnect){
            (data, ack) in
                self._cli_status = Client_Status.failed
        }
    }
    func read_cl()->String{
        return "MSG_SENT"
    }
    
    func write_cl(data_:String, req_type_:Request_Type)->Any?{
        self._cli_status = Client_Status.reading
        print("Called write func")
        switch req_type_ {
        case .login:
            return login_handler(sock_:_sock, req_type_str: "LOGIN", body: data_)
        case .call:
            call_handler(sock_:_sock, req_type_str: "CALL", body: data_)
            break
        case .priority_call:
            p_call_handler(sock_:_sock, req_type_str: "P_CALL", body: data_)
            break
        case .arrived:
            arrived_handler(sock_:_sock, req_type_str: "ARRIVED", body: data_)
            break
        case .obj_sent:
            obj_sent_handler(sock_:_sock, req_type_str: "OBJ_SENT", body: data_)
            break
        case .obj_recieved:
            obj_rcv_handler(sock_:_sock, req_type_str: "OBJ_RCV", body: data_)
            break
        case .cancel:
            cancel_handler(sock_:_sock, req_type_str: "CANCEL", body: data_)
            break
        case .timeout:
            timeout_handler(sock_:_sock, req_type_str: "TIMEOUT", body: data_)
            break
        case .invalid:
            invalid_handler(sock_: _sock, req_type_str: "INVALID", body: data_)
        }
        
        self._cli_status = Client_Status.waiting
        return nil

    }
   
}

func connect_cl(){
    let cli:Client_SIO = Client_SIO()
    cli.connect_cl()
}



