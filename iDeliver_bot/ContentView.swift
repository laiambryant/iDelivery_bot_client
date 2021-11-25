//
//  ContentView.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel:iDelivery_bot_VM
    
    var body: some View {
        VStack{
            Header()
            Spacer()
            Login_form(viewModel_: viewModel)
        }
    }

}

struct Header:View{
    var body:some View{
        Text("iDelivery BOT").fontWeight(.bold).font(.title)
        Image("Robot").resizable().aspectRatio(contentMode: .fit).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct Login_form:View{
    @ObservedObject var viewModel_:iDelivery_bot_VM
    var body:some View{
        Form{
            HStack{
                Username_textfield(viewModel: viewModel_)
                Password_textfield(viewModel: viewModel_)
            }
            HStack{
                Connect_button(viewModel: viewModel_)
                Spacer()
                Login_button(viewModel: viewModel_)
            }
        }
    }
}


struct Username_textfield:View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body: some View{
        TextField(text: $viewModel.app._user_data._username, prompt: Text("Username")) {
                Text("Username")
        }.disableAutocorrection(true).textFieldStyle(.automatic).padding(.all)
        }
}
    
struct Password_textfield:View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body: some View{
        SecureField(text: $viewModel.app._user_data._password, prompt: Text("Password")) {
            Text("Password")
        }.disableAutocorrection(true).textFieldStyle(.automatic).padding(.all)
    }
}
    
struct Connect_button:View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body:some View{
        Button(action:{
            viewModel.ni_connect()
        },label:{
            HStack{
                Image(systemName:"antenna.radiowaves.left.and.right.circle")
                Text("Connect")
            }}).buttonStyle(.borderedProminent).disabled(viewModel.ni_isConnected())
    }
}

struct Login_button:View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body:some View{
        Button(action: {
            print(viewModel.verify_credentials())
        }, label:{
            HStack{
              Image(systemName: "dot.circle.and.hand.point.up.left.fill")
              Text("Login    ")
            }}).buttonStyle(.borderedProminent).disabled(!viewModel.ni_isConnected())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: iDelivery_bot_VM())
    }
}

