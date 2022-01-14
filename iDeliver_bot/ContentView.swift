//
//  ContentView.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel_:iDelivery_bot_VM
    var body: some View {
        if((!viewModel_.ni_isLoggedIn())){
            VStack{
                Header()
                Login_form(viewModel_: viewModel_)
            }
        } else {
            VStack{
                Map_header(viewModel: viewModel_)
                Map_buttons(viewModel: viewModel_)
                Map_body(viewModel: viewModel_)
            }
        }
    }
}

struct Header:View{
    var body:some View{
        Text("iDelivery BOT").fontWeight(.bold).font(.title).padding(.all)
        Image("Robot").resizable().aspectRatio(contentMode: .fit).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct Login_form:View{
    @ObservedObject var viewModel_:iDelivery_bot_VM
    var body:some View{
        Form{
            HStack{
                TextField(text: $viewModel_.app._user_data._username, prompt: Text("Username")) {
                        Text("Username")
                }.disableAutocorrection(true).textFieldStyle(.automatic).padding(.all)
                
                SecureField(text: $viewModel_.app._user_data._password, prompt: Text("Password")){
                    Text("Password")
                }.disableAutocorrection(true).textFieldStyle(.automatic).padding(.all)
            }
            Buttons(viewModel: viewModel_)
        }
    }
}


struct Buttons:View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body:some View{
        HStack{
            Connect_button(viewModel: viewModel)
            Spacer()
            Login_button(viewModel: viewModel)
        }
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


struct Map_header : View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body:some View{
        VStack{
            Text("Hello \(viewModel.app._user_data._username)!").fontWeight(.bold).font(.title)
            Text("You can call the robot pressing the call button. Confirm arrival pressing the arrived button when it arrives. At anytime while waiting for the bot you can cancel your request.").padding(.all)
            
        }
    }
}

struct Map_buttons : View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body:some View{
        VStack{
            HStack{
                call_button(viewModel: viewModel)
                arrived_button(viewModel: viewModel)
            }
            HStack{
                cancel_button(viewModel: viewModel)
                recieved_button(viewModel: viewModel)
            }
        }
    }
}


struct Map_body : View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body:some View{
        
        guard let img = UIImage(named:"Map") else {
            fatalError("Unable to load map")
        }
        
        UIGraphicsBeginImageContext(img.size)
        img.draw(at: CGPoint.zero)
        if(viewModel.app._user.exists){
            draw_user(x_: Int(viewModel.app._user.getPos()[0]), y_: Int(viewModel.app._user.getPos()[1]), color: .blue)
        }
        if(!viewModel.app._other_users.isEmpty){
            for user in viewModel.app._other_users {
                draw_user( x_:Int(user.getPos()[0]), y_:Int(user.getPos()[1]), color: .green)
            }
        }
        draw_user(x_:400 ,y_:100, color: UIColor.red)
        draw_robot(bot: viewModel.app.getBot())
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return (
            VStack{
                Image(uiImage:myImage).resizable().aspectRatio(contentMode: .fit).border(.ultraThickMaterial)
                HStack{
                    Text(viewModel.app._user.name_).foregroundColor(.green).bold().border(.ultraThinMaterial)
                    Text("Ross").foregroundColor(.red).bold().border(.ultraThinMaterial)
                }
            }
        )
    }
}

struct call_button:View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body:some View{
        Button(action: {
            viewModel.ni_call()
        }, label:{
            HStack{
              Image(systemName: "phone")
              Text("Call    ")
            }}).buttonStyle(.borderedProminent).disabled(viewModel.ni_isBeingServed())
    }
}

struct recieved_button:View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body:some View{
        Button(action: {
            viewModel.ni_rcv()
        }, label:{
            HStack{
              Image(systemName: "gift")
              Text("Recieved    ")
            }}).buttonStyle(.borderedProminent)
    }
}

struct cancel_button:View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body:some View{
        Button(action: {
            viewModel.ni_cancel()
        }, label:{
            HStack{
              Image(systemName: "x.circle")
              Text("Cancel    ")
            }}).buttonStyle(.borderedProminent).disabled(!viewModel.ni_isBeingServed())
    }
}

struct arrived_button:View{
    @ObservedObject var viewModel:iDelivery_bot_VM
    var body:some View{
        Button(action: {
            viewModel.ni_arrived()
        }, label:{
            HStack{
              Image(systemName: "airplane.arrival")
              Text("Arrived    ")
            }}).buttonStyle(.borderedProminent).disabled(!viewModel.ni_isBeingServed())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel_:iDelivery_bot_VM())
.previewInterfaceOrientation(.portrait)
    }
}
