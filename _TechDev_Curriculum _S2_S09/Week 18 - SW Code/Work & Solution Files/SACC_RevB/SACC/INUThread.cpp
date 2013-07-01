/******************************************************************************
*
*   Class: INUThread.cpp
*
* Purpose: Creates connection to INU, reads in INU data and stores it to
*          Platform Orientation.
*
*   Author: Nathan Soule (minor changes by Austin Dionne)
*
******************************************************************************/

#include "BITControl.h"
#include "Constants.h"
#include "INUThread.h"
#include "NetworkMappings.h"
#include "Messages.h"
#include "MessageLog.h"
#include "PlatformOrientation.h"

using namespace std;

  /****************************************************************************
  *
  *        Name: INUThread
  *
  * Description: Constructor
  * 
  *  Attributes: none
  *
  *      Return: none
  *
  *      Author: Nathan Soule
  *
  ****************************************************************************/

INUThread::INUThread(void):
socket(INU_PORT, INU_HOST)
{
}

  /****************************************************************************
  *
  *        Name: ~INUThread
  *
  * Description: Destructor
  * 
  *  Attributes: none
  *
  *      Return: none
  *
  *      Author: Nathan Soule
  *
  ****************************************************************************/

INUThread::~INUThread(void)
{
}

  /****************************************************************************
  *
  *        Name: Run
  *
  * Description: Connects socket to INU, recieves messages, sends INU data
  *              to platform orientation
  * 
  *  Attributes: none
  *
  *      Return: none
  *
  *      Author: Nathan Soule
  *
  ****************************************************************************/

void INUThread::Run()
{
  try
  {
    MessageLog::Instance()->LogMessage("Connecting to INU interface...");

    // Keep attempting to connect to the socket for SOCKET_RETRY_ATTEMPTS.

    if (socket.Connect(SOCKET_RETRY_ATTEMPTS, SOCKET_RETRY_DELAY))
    {
      MessageLog::Instance()->LogMessage("INU connection established!");
      while(true)
      {
        MessageHeader messageHeader;

        // If a message is not received from the port, print out an error.

        if (!socket.Receive((char*)&messageHeader, sizeof(messageHeader)))
        {
          MessageLog::Instance()->LogMessage("Error receiving data from INU socket!");
        }
        else
        {

          // Read in INU information and store it in the PlatformOrientation singleton class.

          if (messageHeader.ID == ATTITUDE_MESSAGE)
          {
            AttitudeData INUData;
            if (!socket.Receive((char*)&INUData, sizeof(INUData)))
            {
              MessageLog::Instance()->LogMessage("Error receiving data from INU socket!");
            }
            else
            {
              cout << "INU data received -> Azimuth: " << INUData.azimuth << endl;

              PlatformOrientation::Instance()->StoreINUData(FixedToFloat(INUData.azimuth)); 
            }
          }
          else
          {
            // The message was unrecognized. Read the data into a buffer and discard it.
            // The success/failure of the socket read is not checked.
            char buffer[MAXIMUM_POSSIBLE_MESSAGE_LENGTH];
            MessageLog::Instance()->LogMessage("Unrecognized message from the INU interface!");
            socket.Receive((char*)&buffer, messageHeader.length);
          }
        }
        
      }
    }
    else
    {
      MessageLog::Instance()->LogMessage("Error while connecting to INU interface!");
      BITControl::Instance()->RaiseFault(INU_INTERFACE_FAULT);
    }
  }
  catch (exception e)
  {
    MessageLog::Instance()->LogMessage("INU thread terminated due to exception!");
    BITControl::Instance()->RaiseFault(INU_INTERFACE_FAULT);
  }
}
