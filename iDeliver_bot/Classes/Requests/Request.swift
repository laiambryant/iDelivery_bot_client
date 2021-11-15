//
//  Request.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import Foundation

class Request{
    
    private let _req_type:Request_Type
    private var _priority:Int32
    
    init(req_type_:Request_Type){
        _req_type = req_type_
        _priority = 0
    }
    
    func setPriority(priority_:Int32){
        self._priority = priority_
    }
    
}
