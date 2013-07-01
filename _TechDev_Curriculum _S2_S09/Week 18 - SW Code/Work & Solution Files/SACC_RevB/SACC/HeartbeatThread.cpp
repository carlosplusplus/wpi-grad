/******************************************************************************
*
*    Class: HeartbeatThread.cpp
*
*  Purpose: This class is the thread that receives and sends 
*           the heartbeat message to the MC. 
*
*   Author: Gregory Hovagim (edited by Austin Dionne)
*
******************************************************************************/

#include "BITControl.h"
#include "HeartbeatThread.h"
#include "Thread.h"
#include "Messages.h"
#include "MessageLog.h"
#include "MCCMTransceiver.h"

HeartbeatThread::HeartbeatThread()
{

}

HeartbeatThread::~HeartbeatThread(void)
{
}

void HeartbeatThread::Run(void)
{
  try
  {
    while(true)
    {
      HeartbeatMessage hbmessage;
      if (MCCMTransceiver::Instance()->Read((char*)&hbmessage, sizeof(hbmessage)))
      {
        // The heartbeat is only echoed if the system is functional.
        if (BITControl::Instance()->GetSystemBITStatus())
        {
          MCCMTransceiver::Instance()->SendHeartbeatMessage(hbmessage.data.count);
        }
      }
      else
      {
        MessageLog::Instance()->
          LogMessage("Error while reading heartbeat message from MC/CM Transceiver!");
      }
    }
  }
  catch (exception e)
  {
    MessageLog::Instance()->LogMessage("Sensor thread terminated due to exception!");
    BITControl::Instance()->RaiseFault(HEARTBEAT_FAULT);
  }
}