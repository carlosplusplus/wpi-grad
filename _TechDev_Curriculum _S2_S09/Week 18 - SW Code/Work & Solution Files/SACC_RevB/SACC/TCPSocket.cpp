/***************************************************************
*
* Name: TCPSocket.cpp
*
* Description: TCPSocket class wraps the Windows library winsock
*              class and allows for use of built in socket
*              communication.
*
* Author: Carlos Lazo
*
***************************************************************/

#pragma comment(lib, "wsock32.lib")

#include <iostream>
#include <string>
#include <windows.h>
#include <winsock.h>

#include "MessageLog.h"
#include "TCPSocket.h"

using namespace std;

/***************************************************************
*
* Name: TCPSocket (constructor)
*
* Description: Constructs object of type TCPSocket.
* 
* Attributes: port = port used to read information from socket.
*
* Return: Define new ThreatDatabase object.
*
* Author: Carlos Lazo
*
***************************************************************/

TCPSocket::TCPSocket(int port, string host)
{
  this->port = port;
  this->host = host;
}

/***************************************************************
*
* Name: Initialize
*
* Description: Static void function that initializes the Windows
*              SOCKET interface.
* 
* Attributes: NONE.
*
* Return: NONE
*
* Author: Carlos Lazo
*
***************************************************************/

void TCPSocket::Initialize()
{
  WSAData wsa; 
  WSAStartup(MAKEWORD(1, 1), &wsa);
}

/***************************************************************
*
* Name: Connect
*
* Description: Connect the socket with the assigned port number.
*              Attempt to connect only one time.
* 
* Attributes: NONE.
*
* Return: bool -> Return true if connected, false if otherwise.
*
* Author: Carlos Lazo
*
***************************************************************/

bool TCPSocket::Connect()
{
  int port = this->port;

  // Initialize WinSock2 interface.

  this->clientSocket = socket(AF_INET, SOCK_STREAM, 0);

  // Find the host name (IP address) of the host.

  hostent* pHE = gethostbyname(host.c_str());
  
  u_long nRemoteAddress = *((u_long*)pHE->h_addr_list[0]);

  // If the socket is valid, continue trying to connect.

  if (clientSocket != INVALID_SOCKET) 
  {
    // Initialize all socket variables based on derived network address.

    sockaddr_in sinRemote;
    sinRemote.sin_family = AF_INET;
    sinRemote.sin_addr.s_addr = nRemoteAddress;
    sinRemote.sin_port = htons(port);

    // If the socket connection failed, return a failure message.
    
    if (connect(clientSocket, (sockaddr*)&sinRemote, sizeof(sockaddr_in)) == SOCKET_ERROR) 
    {
      MessageLog::Instance()->LogMessage("Connect in class TCPSocket did not connect to the socket correctly!");
      return false;
    }
  }

  else
  {
    MessageLog::Instance()->LogMessage("Connect in class TCPSocket did not construct the socket correctly!");
    return false;
  }

  return true;
}

/***************************************************************
*
* Name: Connect
*
* Description: Connect the socket with the assigned port number.
*              Attempt to connect only one time.
* 
* Attributes: connectAttempts = Number of times the socket will
*                       delay = Number of milliseconds to wait
*                               before the next socket connect.
*
* Return: bool -> Return true if connected, false if otherwise.
*
* Author: Carlos Lazo
*
***************************************************************/

bool TCPSocket::Connect(int connectAttempts, int delay)
{
  int port = this->port;

  // Initialize WinSock2 interface.

  this->clientSocket = socket(AF_INET, SOCK_STREAM, 0);

  // Find the host name (IP address) of the host.

  hostent* pHE = gethostbyname(host.c_str());
  
  u_long nRemoteAddress = *((u_long*)pHE->h_addr_list[0]);

  // If the socket is valid, continue trying to connect.

  if (clientSocket != INVALID_SOCKET) 
  {
    // Initialize all socket variables based on derived network address.

    sockaddr_in sinRemote;
    sinRemote.sin_family = AF_INET;
    sinRemote.sin_addr.s_addr = nRemoteAddress;
    sinRemote.sin_port = htons(port);

    // Attempt to connect to the socket for connectAttempts times.
    
    for (int i = 0; i < connectAttempts; i++)
    {
      // If the socket does not connect, log the message and try again.

      if (connect(clientSocket, (sockaddr*)&sinRemote, sizeof(sockaddr_in)) == SOCKET_ERROR) 
      {
        //MessageLog::Instance()->LogMessage("Connect in class TCPSocket did not connect to the socket correctly! Trying again.");
        Sleep(delay);
      }

      else
      {
        
        //MessageLog::Instance()->LogMessage("Connected!");
        return true;
      }
    }
    MessageLog::Instance()->LogMessage("Aborting socket connection after too many retries.");
    return false;
  }
  else
  {
    MessageLog::Instance()->LogMessage("Connect in class TCPSocket did not construct the socket correctly!");
    return false;
  }
}

/***************************************************************
*
* Name: Receive
*
* Description: Receives information from the respective port and
*              saves it into the passed buffer (struct).
* 
* Attributes: buffer   = Structure associated with receive information.
*             numBytes = Number of bytes in the passed structure.
*
* Return: bool -> Return true if # of bytes received equals # of bytes
*                 expected, false if otherwise.
*
* Author: Carlos Lazo
*
***************************************************************/


bool TCPSocket::Receive(char* buffer, int numBytes)
{
  // Number of bytes received by the socket.

  int iResult = 0;

  iResult = recv(clientSocket, buffer, numBytes, 0);
  
  return (iResult == numBytes);

}

/***************************************************************
*
* Name: Send
*
* Description: Sends information to the respective port of the
*              given TCPSocket.
* 
* Attributes: buffer   = Structure associated with send information.
*             numBytes = Number of bytes in the passed structure.
*
* Return: bool -> Return true if data is sent, false otherwise.
*
* Author: Carlos Lazo
*
***************************************************************/

bool TCPSocket::Send(char* buffer, int numBytes)
{
  return send(clientSocket, buffer, numBytes, 0);
}

/***************************************************************
*
* Name: Close
*
* Description: Closes the socket associated with the respective
*              TCPSocket.
* 
* Attributes: NONE.
*
* Return: NONE.
*
* Author: Carlos Lazo
*
***************************************************************/

void TCPSocket::Close()
{
  closesocket(clientSocket);
}

/***************************************************************
*
* Name: GetPort
*
* Description: Return the port # associated with the respective
*              TCPSocket.
* 
* Attributes: NONE.
*
* Return: NONE.
*
* Author: Carlos Lazo
*
***************************************************************/

int TCPSocket::GetPort()
{
  return port;
}

/***************************************************************
*
* Name: GetHost
*
* Description: Return the host name associated with the respective
*              TCPSocket.
* 
* Attributes: NONE.
*
* Return: NONE.
*
* Author: Carlos Lazo
*
***************************************************************/

string TCPSocket::GetHost()
{
  return host;
}

/***************************************************************
*
* Name: GetSocket
*
* Description: Return the SOCKET associated with the respective
*              TCPSocket.
* 
* Attributes: NONE.
*
* Return: NONE.
*
* Author: Carlos Lazo
*
***************************************************************/

SOCKET TCPSocket::GetSocket()
{
  return clientSocket;
}