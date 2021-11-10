//
//  Client.cpp
//  iDeliver_bot
//
//  Created by Liam Bryant on 10/11/21.
//

#include "Client.hpp"

Client::Client(debug_modes debug_mode_){
    _debug_mode = debug_mode_;
    _port = PORT;
    _sock_fd = socket(AF_INET, SOCK_STREAM, 0);
    if(_sock_fd <0){
        print_debug("Error in Client::ctor(), could not create socket");
        exit(EXIT_FAILURE);
    }
    _outdata.open("client_log.txt");
    _sockaddr.sin_family = AF_INET;
    _sockaddr.sin_port = htons(2021);
    _sockaddr.sin_addr.s_addr = inet_addr(ADDR);
    print_debug("Client::ctor() success! Waiting for further instructions");
    _status = waiting;
}
Client::~Client(){
    _outdata.close();
    close(_sock_fd);
}

bool Client::connect_cl(){
    if (_status == waiting){
        int res = connect(_sock_fd, (struct sockaddr *)&(_sockaddr), sizeof(_sockaddr));
        if(res<0) {
            print_debug("Error in Client::connect_cl() function...");
            _status = failed;
            return false;
        }
        else {
            print_debug("Client::connect_cl() success! You are connected!");
            _status = connected;
            return true;
        }
    }
    else return false;
}

void Client::read_cl(){
    size_t n = 0;
    while((n = read(_sock_fd,_data_buffer, sizeof(_data_buffer)-1 ))>0){
        _data_buffer[n] = 0;
        print_debug("Reading data from Server...");
    }
}

void Client::print_debug(string debug_str){
        if(_debug_mode==log) _outdata << debug_str <<endl<<endl;
        if(_debug_mode==cerr) std::cerr<<debug_str<<endl<<endl;
        if(_debug_mode==cout) std::cout<<debug_str<<endl<<endl;
        if(_debug_mode==none) return;
}
