/***************************************************************
*
* Name: SensorThread.h
*
* Description: SensorThread class reads in threat information
*              when received from the Sensor. If the threat is
*              found in the ThreatDatabase, then a Track is
*              created and added to the TrackDatabase.  If not,
*              send an Unknown Threat message to the CM.
*
* Author: Carlos Lazo
*
***************************************************************/

#pragma once
#pragma comment(lib, "wsock32.lib")

#include <iostream>
#include <winsock.h>

#include "TCPSocket.h"
#include "Thread.h"
#include "ThreatDatabase.h"
#include "TrackDatabase.h"

class SensorThread :
  public Thread
{
private:

  // Declare private member variables.

  TCPSocket clientSocket;
  ThreatDatabase* myThreats;
  TrackDatabase*   myTracks;


public:

  /***************************************************************
  *
  * Name: SensorThread (constructor)
  *
  * Description: Constructs object of type SensorThread. Also
  *              initializes the TCPSocket for the SensorThread.
  * 
  * Attributes: threadDB = pointer to the ThreatDatabase
  *              trackDB = pointer to the TrackDatabase.
  *
  * Return: Define new SensorThread object.
  *
  * Author: Carlos Lazo
  *
  ***************************************************************/

  SensorThread(ThreatDatabase* myThreats, TrackDatabase* myTracks);

  /***************************************************************
  *
  * Name: Run
  *
  * Description: Run is called when the Thread is actually started.
  *              It reads all information received from the sensor
  *              and interprets it accordingly.
  * 
  * Attributes: NONE.
  *
  * Return: NONE.
  *
  * Author: Carlos Lazo
  *
  ***************************************************************/

  virtual void Run(void);
};