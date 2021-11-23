//
//  ContentView.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var viewModel:iDelivery_bot
    var body: some View {
        VStack{
            Header()
            Spacer()
            Login_form(viewModel: viewModel)
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
    var viewModel:iDelivery_bot
    var body:some View{
        Form{
            HStack{
                Username_textfield(username_:viewModel._user_data._username)
                Password_textfield(password_:viewModel._user_data._password)
            }
            HStack{
                Connect_button(isConnected: viewModel.isConnected)
                Spacer()
                Login_button(isConnected: viewModel.isConnected)
            }
        }
    }

    struct Username_textfield:View{
        @State var username_:String
        
        var body: some View{
            TextField(text: $username_, prompt: Text("Username")) {
                Text("Username")
            }.disableAutocorrection(true).textFieldStyle(.automatic).padding(.all)
        }
    }
    
    struct Password_textfield:View{
        @State var password_:String
        var body: some View{
            SecureField(text: $password_, prompt: Text("Password")) {
                Text("Password")
                }.disableAutocorrection(true).textFieldStyle(.automatic).padding(.all)
        }
    }
    
    struct Connect_button:View{
        @State var isConnected:Bool
        var body:some View{
            Button(action:{
                
            },label:{
                HStack{
                    Image(systemName:"antenna.radiowaves.left.and.right.circle")
                    Text("Connect")
                }}).buttonStyle(.borderedProminent).disabled(isConnected)
            
        }
    }
    
    struct Login_button:View{
        @State var isConnected:Bool
        var body:some View{
            Button(action: {
                
            }, label:{
                HStack{
                  Image(systemName: "dot.circle.and.hand.point.up.left.fill")
                  Text("Login    ")
            }}).buttonStyle(.borderedProminent).disabled(!isConnected)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: iDelivery_bot())
    }
}

