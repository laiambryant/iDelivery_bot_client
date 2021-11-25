//
//  iDeliver_botApp.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import SwiftUI

@main
struct iDeliver_botApp:App{
    
    let viewModel_:iDelivery_bot_VM = iDelivery_bot_VM()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel:viewModel_)
        }
    }

}

