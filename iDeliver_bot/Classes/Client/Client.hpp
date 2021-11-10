//
//  Client.hpp
//  iDeliver_bot
//
//  Created by Liam Bryant on 10/11/21.
//

#ifndef Client_hpp
#define Client_hpp

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <iostream>
#include <unistd.h>
#include <vector>
#include <fstream>

#define PORT 8080
#define ADDR "127.0.0.1"
#define BUF_SIZE 1024

using std::string;
using std::endl;
using std::ofstream;

enum client_status{
    waiting, connected, failed
};
enum debug_modes{
    cerr, cout, log, none
};

class Client{
public:
    Client(debug_modes debug_mode_);
    ~Client();
    bool connect_cl();
    void read_cl();
    
    
private:
    //set_status and get_status are only used to keep code clean even if unnecessary
    void set_status(client_status status_) {_status = status_;};
    client_status get_status() {return _status;};
    void print_debug(string debug_str);
    int _sock_fd;
    int _port;
    char _data_buffer[BUF_SIZE];
    ofstream _outdata;
    sockaddr_in _sockaddr;
    debug_modes _debug_mode;
    client_status _status;
    
protected:
    
};

#endif /* Client_hpp */
