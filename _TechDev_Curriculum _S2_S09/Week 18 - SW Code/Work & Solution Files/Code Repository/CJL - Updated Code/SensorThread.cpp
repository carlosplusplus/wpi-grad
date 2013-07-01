/***************************************************************
*
* Name: SensorThread.cpp
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

#include "Messages.h"
#include "MessageLog.h"
#include "MCCMTransceiver.h"
#include "NetworkMappings.h"
#include "PlatformOrientation.h"
#include "SensorThread.h"
#include "SystemClock.h"
#include "TCPSocket.h"
#include "Thread.h"
#include "Track.h"

#include <iostream>
#include <windows.h>

using namespace std;

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

SensorThread::SensorThread(ThreatDatabase* threatDB, TrackDatabase* trackDB)
:clientSocket(SENSOR_PORT, SENSOR_HOST)
{
  cout << "sensorThread function" << endl;

  myThreats = threatDB;
  myTracks  =  trackDB;
}

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

void SensorThread::Run(void)
{

  // Try catch statement with BIT integration.
  // Replace with new overloaded Connect function.

  if(!clientSocket.Connect());
  {
    MessageLog::Instance()->LogMessage("In class SensorThread, the socket did not sent correctly!");
  }

  // Run this thread indefinitely.
 
  while(true)
  {
    MessageHeader msgHeader;

    // If the first 8 bytes of the message header are not received correctly, throw an error.

    if (!clientSocket.Receive((char*)&msgHeader,sizeof(msgHeader)))
    {
      MessageLog::Instance()->LogMessage("The Sensor message header was not sent correctly!");
    }

    // Assuming that our message ID received is that of a threat we are expecting, read in the Threat data.

    if (msgHeader.ID == THREAT_DETECTION_ID)
    {
      ThreatDetectionData newThreatData;

      if (clientSocket.Receive((char*)&newThreatData, sizeof(newThreatData)))
      {

        // Check to see if we know what this threat is in our ThreatDatabase by waveform.

        Threat* searchThreat = myThreats->FindThreatByWF(newThreatData.waveform);

        // If we found our Threat in our database and we know how to counter it, continue processing.

        if (searchThreat != NULL)
        {

          // Figure out when the Track is going to hit our vehicle using the System Clock, threat range, and threat velocity.

          float timeOfArrival = SystemClock::Instance()->GetCurrentTime() + (FixedToFloat(newThreatData.range))/(searchThreat->GetVelocity());
          
          // Figure out where the based on the azimuth received from the Sensor.
          
          float threatOrientation = FixedToFloat(newThreatData.azimuth);

          // Check to see if our current orientation is out of bounds.

          if (threatOrientation > 360.0)
          {
            threatOrientation = threatOrientation - 360.0;
          }
          else if (threatOrientation < 0.0)
          {
            threatOrientation = threatOrientation + 360.0;
          }

          // Create and add a Track to the TrackDatabase, which prioritizes the CM based on time of arrival.

          Track* currentTrack = new Track(timeOfArrival, searchThreat->GetThreatID(), threatOrientation);

          myTracks->AddTrack(currentTrack);

        }

        // If the Threat* == NULL, then we do not know how to counter the Threat.
        // Send an Unknown Threat message to the MC.

        else
        {
          MCCMTransceiver::Instance()->SendUnknownThreatMessage(newThreatData.azimuth);
        }            

      }

      else
      {
        MessageLog::Instance()->LogMessage("The Sensor data was not sent correctly!");
      }
    }

    else
    {
      MessageLog::Instance()->LogMessage("The Sensor message ID was not sent correctly!");
    }
  }
}