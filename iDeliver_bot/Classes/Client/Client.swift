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

class Client{
    
    private var _sock:SocketIOClient
    private var _cli_status:Client_Status
    private var _buffer:[Character] = []
    private let _port:UInt16 = 8080
    private let _manager:SocketManager
    private let _requests_str:[String] = [
        "login", "call", "priority_call", "arrived",
        "obj_sent", "obj_recieved", "cancel", "timeout"
    ]
    init() {
        _manager = SocketManager(socketURL: URL(string: "http://localhost:" + String(_port))!, config: [.log(true), .compress])
        _sock = _manager.defaultSocket
        _cli_status = Client_Status.waiting
    }
    
    func connect_cl()->Void{
        _sock.on(clientEvent: .connect){
            (data, ack) in
            print("Socket connected")
            self._cli_status = Client_Status.waiting
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
        
        //Write possible writes here
        _sock.emit("", data_)
        
        self._cli_status = Client_Status.waiting
    }
}



