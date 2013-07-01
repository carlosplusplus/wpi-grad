/******************************************************************************
*
*    Class: CMControllerThread
*
*  Purpose: This thread loops indefinitely, finding the highest priority 
*           threat in the track database and allocating the countermeasure
*           accordingly.
*
*   Author: Austin Dionne
*
******************************************************************************/

#include "BITControl.h"
#include "Constants.h"
#include "CMControllerThread.h"
#include "MessageLog.h"
#include "MCCMTransceiver.h"
#include "PlatformOrientation.h"
#include "SystemClock.h"

/******************************************************************************
*
*        Name: CMControllerThread (constructor)
*
* Description: Constructs a new CMControllerThread. References to the track
*              and thread databases must be provided.
* 
*  Attributes: None
*
*      Return: N/A
*
*      Author: Austin Dionne
*
******************************************************************************/
CMControllerThread::CMControllerThread(ThreatDatabase* threatDatabase, 
                                       TrackDatabase* trackDatabase):
threatDatabase(threatDatabase),
trackDatabase(trackDatabase),
enabledCM(false)
{}

/******************************************************************************
*
*        Name: CMControllerThread (destructor)
*
* Description: Deallocates resources associated with the CMControllerThread.
* 
*  Attributes: N/A
*
*      Return: N/A
*
*      Author: Austin Dionne
*
******************************************************************************/
CMControllerThread::~CMControllerThread(void)
{

}

/******************************************************************************
*
*        Name: Run
*
* Description: Performs the main function of the thread.
* 
*  Attributes: None
*
*      Return: N/A
*
*      Author: Austin Dionne
*
******************************************************************************/
void CMControllerThread::Run(void)
{
  try
  {
    // This task loops forever, updating the CM.
    while (true)
    {
      // This loop will search for the highest priority track. If expired 
      // tracks are found it will remove them and continue searching. 
      // The loop terminates when a valid track is found and the CM is 
      // directed at the track, or when there are no tracks left.
      bool doneTrackLoop = false;
      while (!doneTrackLoop)
      {
        // Get the highest priority threat.
        Track* track = trackDatabase->GetFirstTrack();
        if (track == NULL)
        {
          // There are no more tracks to jam. If the countermeasure was
          // previously enabled, send the TurnOffCM message.
          if (enabledCM)
          {
            enabledCM = false;
            MCCMTransceiver::Instance()->SendTurnOffCMMessage();
          }

          // The track loop is done.
          doneTrackLoop = true;
        }
        else
        {
          // Determine if the track is still a threat.
          if (track->GetTimeOfArrival() > SystemClock::Instance()->GetCurrentTime())
          {
            // Look up the threat type in the threat database in order to determine
            // the jam code to use.
            Threat* threat = threatDatabase->FindThreatByID(track->GetThreatID());
            
            // Determine the azimuth in platform coordinates to direct the CM.
            float targetAzimuth = track->GetAngleOfArrival() -
              PlatformOrientation::Instance()->GetCurrentAzimuth();

            // Keep the calculated azimuth within the valid range.
            if (targetAzimuth > 360.0)
            {
              targetAzimuth -= 360.0;
            }
            else if (targetAzimuth < 0.0)
            {
              targetAzimuth += 360.0;
            }

            // Send the AllocateCM message via the MCCMTransceiver.
            enabledCM = true;
            MCCMTransceiver::Instance()->SendAllocateCMMessage(targetAzimuth, threat->GetJamCode());

            // The track loop is done.
            doneTrackLoop = true;
          }
          else
          {
            // The track has expired. Remove it from the track database and the
            // next iteration of the loop will attempt to find a valid track.
            trackDatabase->RemoveFirstTrack();
          }
        }
      }

      /* The following code does not work with the current version of Mother,
         because Mother can not respond to AllocateCM messages quickly enough.

      // Determine whether or not the countermeasure will require updating
      // faster than the normal rate. If the current angular velocity of the
      // platform is great enough that we will not stay within the tolerable
      // error, no delay will occur before the next CM update. Note that the
      // default CM update delay is in milliseconds.
      float expectedError = abs(PlatformOrientation::Instance()->GetCurrentAngularVelocity()
                                * DEFAULT_CM_UPDATE_DELAY / 1000.0);

      if (expectedError < MAXIMUM_CM_ERROR_TOLERANCE)
      {
        Sleep(DEFAULT_CM_UPDATE_DELAY);
      }
      */

      Sleep(DEFAULT_CM_UPDATE_DELAY);
    }
  }
  catch (exception e)
  {
    MessageLog::Instance()->
      LogMessage("Exception raised in CMControllerThread.");
    BITControl::Instance()->RaiseFault(CM_CONTROLLER_FAULT);
  }
}