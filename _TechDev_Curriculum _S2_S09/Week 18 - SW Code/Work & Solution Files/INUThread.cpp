/******************************************************************************
*
*   Class: INU Thread
*
* Purpose: Creates connection to INU, reads in INU data and stores it to
*          Platform Orientation.
*
*   Author: Nathan Soule
*
******************************************************************************/

#include "INUThread.h"
#include "NetworkMappings.h"
#include <iostream>
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
  if (!socket.Connect())
    {
      MessageLog::Instance()->LogMessage("ERROR: Socket did not connect");
    }

while(true)
{
    AttitudeMessage INUData;

    if (!socket.Receive((char*)&INUData, sizeof(INUData)))
      {
       MessageLog::Instance()->LogMessage("ERROR: socket did not receive socket data");
      }
    else
      {
       PlatformOrientation::Instance()->StoreINUData(FixedAzimuthToFloat(INUData.data.azimuth)); 
      }
            //float FixedAzimuthToFloat (long azimuth);
      
  }
}
