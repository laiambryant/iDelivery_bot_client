//
//  Admin_Request.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import Foundation

class Admin_Request:Request{
   
    override init(req_type_:Request_Type) {
        super.init(req_type_:req_type_)
        super.setPriority(priority_: Int32(1))
    }
    
}
