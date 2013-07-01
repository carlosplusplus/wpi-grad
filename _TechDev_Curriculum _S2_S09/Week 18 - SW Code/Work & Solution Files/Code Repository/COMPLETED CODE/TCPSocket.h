#pragma once
#pragma comment(lib, "wsock32.lib")

#include <iostream>
#include <string>
#include <winsock.h>

using namespace std;

class TCPSocket
{

private:

  // Declare private member variables.

  int port;
  string host;
  SOCKET mySocket;

public:

  TCPSocket(int, string);

  static void Initialize();
  bool Connect();
  bool Send(char*, int);
  bool Receive(char*, int);
  void Close();
};