/******************************************************************************
*
*    Class: MCCMTransceiver
*
*  Purpose: This class acts as an interface to the Mission Computer (MC) and
*           Counter Measure (CM). Messages can be sent/received to/from the 
*           MC/CM. The interface was designed to be thread-safe.
*
*   Author: Austin Dionne
*
******************************************************************************/

#pragma once

#include "Semaphore.h"
#include "TCPSocket.h"

class MCCMTransceiver
{
public:

  /****************************************************************************
  *
  *        Name: Instance
  *
  * Description: Returns the single instance of MCCMTransceiver that exists in
  *              the system. The instance is created if it does not yet exist.
  * 
  *  Attributes: None
  *
  *      Return: Pointer to the single instance of MCCMTransceiver.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  static MCCMTransceiver* Instance();
  
  /****************************************************************************
  *
  *        Name: Initialize
  *
  * Description: Initializes the interface and creates the connection to the 
  *              MC/CM interface.
  * 
  *  Attributes: None
  *
  *      Return: True if the connection could be made, false otherwise.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  bool Initialize();
   
  /****************************************************************************
  *
  *        Name: SendUnknownThreatMessage
  *
  * Description: Creates and sends an Unknown Threat message to the MC/CM.
  * 
  *  Attributes: azimuth - azimuth of the unknown threat.
  *
  *      Return: True if the message was sent successfully, false otherwise.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  bool SendUnknownThreatMessage(float azimuth);
  
  /****************************************************************************
  *
  *        Name: SendAllocateCMMessage
  *
  * Description: Creates and sends an Allocate CM message to the MC/CM.
  * 
  *  Attributes: azimuth - azimuth to direct the CM
  *              jamCode - jamCode to direct the CM to use
  *
  *      Return: True if the message was sent successfully, false otherwise.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  bool SendAllocateCMMessage(float azimuth, int jamCode);
  
  /****************************************************************************
  *
  *        Name: SendTurnOffCMMessage
  *
  * Description: Creates and sends a message to the MC/CM to turn off the CM.
  * 
  *  Attributes: None
  *
  *      Return: True if the message was sent successfully, false otherwise.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  bool SendTurnOffCMMessage();

  /****************************************************************************
  *
  *        Name: SendHeartbeatMessage
  *
  * Description: Creates and sends a Heartbeat message to the MC/CM.
  * 
  *  Attributes: count - count to be echoed back to the MC/CM. This count 
  *              should match that of the last Heartbeat message received from
  *              the MC/CM.
  *
  *      Return: True if the message was sent successfully, false otherwise.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  bool SendHeartbeatMessage(long count);
  
  /****************************************************************************
  *
  *        Name: Read
  *
  * Description: Reads data from the MC/CM interface. This command will block
  *              until the requested number of bytes are received.
  * 
  *  Attributes: buffer - address to copy the bytes read into
  *              numberOfBytes - number of bytes to read from the interface
  *
  *      Return: True if the message was read successfully, false otherwise.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  bool Receive(char* buffer, int numberOfBytes);

private:

  // Single instance of the MCCMTransceiver.
  static MCCMTransceiver* instance;

  // Semaphores used for protecting the socket read/write interfaces.
  Semaphore sendSemaphore;
  Semaphore readSemaphore;
  TCPSocket socket;
  
  /****************************************************************************
  *
  *        Name: MCCMTransceiver (constructor)
  *
  * Description: Creates an MCCMTransceiver. This transceiver must be
  *              initialized (creating the connection) before use.
  * 
  *  Attributes: None
  *
  *      Return: N/A
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  MCCMTransceiver(void);
  
  /****************************************************************************
  *
  *        Name: MCCMTransceiver (destructor)
  *
  * Description: Deallocates any resources associated with the MCCMTransceiver.
  * 
  *  Attributes: None
  *
  *      Return: N/A
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  ~MCCMTransceiver(void);
};