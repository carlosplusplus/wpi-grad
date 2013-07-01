/******************************************************************************
*
*    Class: HeartbeatThread.cpp
*
*  Purpose: This class is the thread that receives and sends 
*           the heartbeat message to the MC. 
*
*   Author: Gregory Hovagim
*
******************************************************************************/

#include "HeartbeatThread.h"
#include "Thread.h"
#include "Messages.h"
#include "MessageLog.h"
#include "MCCMTransceiver.h"
#include <iostream>
using namespace std;

HeartbeatThread::HeartbeatThread()
{
}

HeartbeatThread::~HeartbeatThread(void)
{
}

void HeartbeatThread::Run(void)
{
  while(true)
  {
    struct HeartbeatMessage hbmessage;
    MCCMTransceiver::Instance()->Receive((char*)&hbmessage, sizeof(hbmessage));

    cout << hbmessage.data.count << endl;
    cout << "is count incrementing" << endl;
  }
}