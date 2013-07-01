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

#include "BITControl.h"
#include "Constants.h"
#include "MCCMTransceiver.h"
#include "MessageLog.h"
#include "Messages.h"
#include "NetworkMappings.h"

MCCMTransceiver* MCCMTransceiver::instance = NULL;

/******************************************************************************
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
******************************************************************************/
MCCMTransceiver::MCCMTransceiver(void):
socket(MC_CM_PORT, MC_CM_HOST)
{
  
}

/******************************************************************************
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
******************************************************************************/
MCCMTransceiver::~MCCMTransceiver(void)
{
}

/******************************************************************************
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
******************************************************************************/
MCCMTransceiver* MCCMTransceiver::Instance()
{
  if (instance == NULL)
  {
    instance = new MCCMTransceiver();
  }
  
  return instance;
}

/******************************************************************************
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
******************************************************************************/
bool MCCMTransceiver::Initialize()
{
  if (!sendSemaphore.Initialize())
  {
    MessageLog::Instance()->
      LogMessage("sendSemaphore initialization failed in MCCMTransceiver::Initialize()!");
    return false;
  }

  if (!readSemaphore.Initialize())
  {
    MessageLog::Instance()->
      LogMessage("readSemaphore initialization failed in MCCMTransceiver::Initialize()!");
    return false;
  }

  MessageLog::Instance()->LogMessage("Connecting to MC/CM interface...");
  if (socket.Connect(SOCKET_RETRY_ATTEMPTS, SOCKET_RETRY_DELAY))
  {
    MessageLog::Instance()->LogMessage("MC/CM connection established!");
  }
  else
  {
    MessageLog::Instance()->LogMessage("Error while connecting to MC/CM interface!");
    BITControl::Instance()->RaiseFault(MC_CM_INTERFACE_FAULT);
    return false;
  }

  return true;
}

/******************************************************************************
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
******************************************************************************/
bool MCCMTransceiver::SendUnknownThreatMessage(float azimuth)
{
  bool success;
  struct UnknownThreatMessage message;
  message.header.length = sizeof(message);
  message.header.ID = UNKNOWN_THREAT_ID;
  message.data.azimuth = FloatToFixed(azimuth);

  sendSemaphore.Obtain(Semaphore::WAIT_FOREVER);
  success = socket.Send((char*)&message, sizeof(message));
  Sleep(100);
  if (!success)
  {
    MessageLog::Instance()->
      LogMessage("Failed sending UnkownThreatMessage in MCCMTransceiver");
  }
  Sleep(100);
  sendSemaphore.Release();
  return success;
}

/******************************************************************************
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
******************************************************************************/
bool MCCMTransceiver::SendAllocateCMMessage(float azimuth, int jamCode)
{
  bool success;
  struct AllocateCMMessage message;
  message.header.length = sizeof(message);
  message.header.ID = ALLOCATE_CM_ID;
  message.data.azimuth = FloatToFixed(azimuth);
  message.data.jamCode = jamCode;

  sendSemaphore.Obtain(Semaphore::WAIT_FOREVER);
  success = socket.Send((char*)&message, sizeof(message));
  if (!success)
  {
    MessageLog::Instance()->
      LogMessage("Failed sending AllocateCMMessage in MCCMTransceiver");
  }
  sendSemaphore.Release();
  return success;
}

/******************************************************************************
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
******************************************************************************/
bool MCCMTransceiver::SendTurnOffCMMessage()
{
  bool success;

  // The TurnOffCMMessage consists of only a header.
  struct MessageHeader message;
  message.length = sizeof(message);
  message.ID = TURN_OFF_CM_ID;

  sendSemaphore.Obtain(Semaphore::WAIT_FOREVER);
  Sleep(100);
  success = socket.Send((char*)&message, sizeof(message));
  if (!success)
  {
    MessageLog::Instance()->
      LogMessage("Failed sending TurnOffCMMessage in MCCMTransceiver");
  }
  Sleep(100);
  sendSemaphore.Release();
  return success;
}

/******************************************************************************
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
******************************************************************************/
bool MCCMTransceiver::SendHeartbeatMessage(long count)
{
  bool success;
  struct HeartbeatMessage message;
  message.header.length = sizeof(message);
  message.header.ID = HEARTBEAT_ID;
  message.data.count = count;

  sendSemaphore.Obtain(Semaphore::WAIT_FOREVER);
  success = socket.Send((char*)&message, sizeof(message));
  if (!success)
  {
    MessageLog::Instance()->
      LogMessage("Failed sending HeartbeatMessage in MCCMTransceiver");
  }
  sendSemaphore.Release();
  return success;
}

/******************************************************************************
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
******************************************************************************/
bool MCCMTransceiver::Read(char* buffer, int numberOfBytes)
{
  bool success;
  readSemaphore.Obtain(Semaphore::WAIT_FOREVER);
  success = socket.Receive(buffer, numberOfBytes);
  readSemaphore.Release();
  if (!success)
  {
    MessageLog::Instance()->
      LogMessage("Socket read failed in MCCMTransceiver");
  }
  return success;
}
