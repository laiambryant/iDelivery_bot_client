//
//  ContentView.swift
//  iDeliver_bot
//
//  Created by Liam Bryant on 09/11/21.
//

import SwiftUI


struct ContentView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    
    
    var body: some View {
        VStack{
            Text("iDelivery BOT").fontWeight(.bold).font(.title)
            Image("Robot").resizable().aspectRatio(contentMode: .fit)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Spacer()
            Form{
                HStack{
                    TextField(text: $username, prompt: Text("Username")) {
                           Text("Username")
                    }.disableAutocorrection(true).textFieldStyle(.automatic).padding(.all)
                    
                    SecureField(text: $password, prompt: Text("Password")) {
                           Text("Password")
                    }.disableAutocorrection(true).textFieldStyle(.automatic).padding(.all)
                }
                HStack{
                    Button(action: {}, label:{
                        HStack{
                            Image(systemName: "dot.circle.and.hand.point.up.left.fill")
                            Text("Login")
                        }}).buttonStyle(.borderedProminent)
                    Spacer()
                    Button(action:{}, label:{
                        HStack{
                            Image(systemName: "person.fill.questionmark")
                            Text("Forgot PW?")
                        }}).buttonStyle(.borderedProminent)
                }.padding(.all)
                
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
