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
* Author: Carlos Lazo (minor changes by Austin Dionne)
*
***************************************************************/

#include "BITControl.h"
#include "Constants.h"
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
:socket(SENSOR_PORT, SENSOR_HOST)
{
  myThreats = threatDB;
  myTracks  =  trackDB;
}

/***************************************************************
*
* Name: ProcessNewThreatData
*
* Description: This procedure processes new threat data received
*              from the sensor by looking it up in the threat
*              database, then building a track and adding it to
*              the track database if found, or sending an
*              UnknownThreatMessage via the MC/CM Transceiver.
* 
* Attributes: NONE.
*
* Return: NONE.
*
* Author: Carlos Lazo
*
***************************************************************/

void SensorThread::ProcessNewThreatData(ThreatDetectionData &data)
{
  // Check to see if we know what this threat is in our ThreatDatabase by waveform.

  Threat* searchThreat = myThreats->FindThreatByWF(data.waveform);

  // If we found our Threat in our database and we know how to counter it, continue processing.

  if (searchThreat != NULL)
  {

    // Figure out when the Track is going to hit our vehicle using the System Clock, threat range, and threat velocity.

    double timeOfArrival = SystemClock::Instance()->GetCurrentTime() + (FixedToFloat(data.range))/(searchThreat->GetVelocity());
    
    // cout << "Vel = " << searchThreat->GetVelocity() << " JC = " << searchThreat->GetJamCode() << endl;

    // Figure out where the based on the azimuth received from the Sensor.
    
    float threatOrientation = FixedToFloat(data.azimuth);

    // Create and add a Track to the TrackDatabase, which prioritizes the CM based on time of arrival.

    Track* currentTrack = new Track(timeOfArrival, searchThreat->GetThreatID(), threatOrientation);

    myTracks->AddTrack(currentTrack);

  }

  // If the Threat* == NULL, then we do not know how to counter the Threat.
  // Send an Unknown Threat message to the MC.

  else
  {
    MCCMTransceiver::Instance()->SendUnknownThreatMessage(FixedToFloat(data.azimuth));
  }            
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
  try
  {
    MessageLog::Instance()->LogMessage("Connecting to sensor interface...");
    if (socket.Connect(SOCKET_RETRY_ATTEMPTS, SOCKET_RETRY_DELAY))
    {
      MessageLog::Instance()->LogMessage("Sensor connection established!");

       // Run this thread indefinitely.
      while(true)
      {
        MessageHeader msgHeader;

        // If the first 8 bytes of the message header are not received correctly, throw an error.

        if (!socket.Receive((char*)&msgHeader,sizeof(msgHeader)))
        {
          MessageLog::Instance()->LogMessage("The Sensor message header was not sent correctly!");
        }
        else
        {

          // Assuming that our message ID received is that of a threat we are expecting, read in the Threat data.

          if (msgHeader.ID == THREAT_DETECTION_ID)
          {
            ThreatDetectionData newThreatData;

            if (socket.Receive((char*)&newThreatData, sizeof(newThreatData)))
            {
              cout << "Sensor data received -> Azimuth: " << newThreatData.azimuth;
              cout << " , Jam Range: " << newThreatData.range << endl;

              ProcessNewThreatData(newThreatData);
            }
            else
            {
              MessageLog::Instance()->LogMessage("The Sensor data was not sent correctly!");
            }
          }
          else
          {
            // The message was unrecognized. Read the data into a buffer and discard it.
            // The success/failure of the socket read is not checked.
            char buffer[MAXIMUM_POSSIBLE_MESSAGE_LENGTH];
            MessageLog::Instance()->LogMessage("Unrecognized message from the sensor interface!");
            socket.Receive((char*)&buffer, msgHeader.length);
          }
        }
      }
    }
    else
    {
      MessageLog::Instance()->LogMessage("Error while connecting to sensor interface!");
      BITControl::Instance()->RaiseFault(SENSOR_INTERFACE_FAULT);
    }
  }
  catch (exception e)
  {
    MessageLog::Instance()->LogMessage("Sensor thread terminated due to exception!");
    BITControl::Instance()->RaiseFault(SENSOR_INTERFACE_FAULT);
  }
}