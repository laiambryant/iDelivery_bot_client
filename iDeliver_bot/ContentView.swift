//
//  ContentView.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import SwiftUI


struct ContentView: View {
    
    @State private var username_: String = ""
    @State private var password_: String = ""
    private var cli:Client_SIO = Client_SIO()
    @State private var isConnected:Bool = false
    
    var body: some View {
        VStack{
            Text("iDelivery BOT").fontWeight(.bold).font(.title)
            Image("Robot").resizable().aspectRatio(contentMode: .fit).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Spacer()
            Form{
                HStack{
                    TextField(text: $username_, prompt: Text("Username")) {
                        Text("Username")
                    }.disableAutocorrection(true).textFieldStyle(.automatic).padding(.all)
                SecureField(text: $password_, prompt: Text("Password")) {
                    Text("Password")
                    }.disableAutocorrection(true).textFieldStyle(.automatic).padding(.all)
                }
                HStack{
                    if(isConnected){
                        let connect_btn = Button( action:{ },label:{
                            HStack{
                                Image(systemName:"antenna.radiowaves.left.and.right.circle")
                                Text("Connect")
                            }}).buttonStyle(.borderedProminent).disabled(true)
                        connect_btn
                        Spacer()
                        let ret:String = "username:"+username_+",password:"+password_
                        Button(action: { cli.write_cl(data_: ret, req_type_: .login)}, label:{
                            HStack{
                                Image(systemName: "dot.circle.and.hand.point.up.left.fill")
                                Text("Login    ")
                            }}).buttonStyle(.borderedProminent)
                    }else{
                          let connect_btn = Button( action:{ cli.connect_cl(); isConnected = !isConnected;},
                                                    label:{
                              HStack{
                                  Image(systemName:"antenna.radiowaves.left.and.right.circle")
                                  Text("Connect")
                              }}).buttonStyle(.borderedProminent)
                          connect_btn
                          Spacer()
                          Button(action: {}, label:{
                              HStack{
                                  Image(systemName: "dot.circle.and.hand.point.up.left.fill")
                                  Text("Login    ")
                              }}).buttonStyle(.borderedProminent).disabled(true)
                    }
                }
        
            }.background(Color.white).onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear {
                UITableView.appearance().backgroundColor = .systemGroupedBackground
            }
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
