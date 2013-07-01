/***************************************************************
*
* Name: TCPSocket.h
*
* Description: TCPSocket class wraps the Windows library winsock
*              class and allows for use of built in socket
*              communication.
*
* Author: Carlos Lazo
*
***************************************************************/

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
  SOCKET clientSocket;

public:

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

  TCPSocket(int, string);

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

  static void Initialize();
  
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

  bool Connect();

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

  bool Connect(int connectAttempts, int delay);

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
  
  bool Send(char*, int);

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

  bool Receive(char*, int);

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

  void Close();

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

  int    GetPort();

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

  string GetHost();

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

  SOCKET GetSocket();
};