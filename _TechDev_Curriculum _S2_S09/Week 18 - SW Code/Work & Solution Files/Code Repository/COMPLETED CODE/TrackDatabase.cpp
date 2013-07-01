/******************************************************************************
*
*   Class: TrackDatabase
*
* Purpose: This class maintains a priortized list of all of the known threat
*          tracks, priority is based on time of arrival, earliest time of arrival
*          is considered top priority.
*
*   Author: Nathan Soule
*
******************************************************************************/

#include <algorithm>
#include <iostream>
#include <vector>
//#include "MessageLog.h"
#include "TrackDatabase.h"
using namespace std;

//this file needs to be thread protected because multiple threads will be accessing it, so semaphore is
//included in all of the functions used.

/******************************************************************************
*
*        Name: LessThan
*
* Description: Compares the time of arrivals of tracks in Track database, used
*              in sort 
* 
*  Attributes: left, right
*
*      Return: bool
*
*      Author: Nathan Soule
*
******************************************************************************/

bool LessThan(Track* left, Track* right)
{
    return left->GetTimeOfArrival() < right->GetTimeOfArrival();
}


/******************************************************************************
*
*        Name: TrackDatabase
*
* Description: Constructor
*
*      Return: none
*
*      Author: Nathan Soule
*
******************************************************************************/

TrackDatabase::TrackDatabase()
{
  /*
  if (!semaphore.Initialize())
  {
    MessageLog::Instance()->LogMessage("semaphore for track database Initialize Failed");
  }
  */
}

/******************************************************************************
*
*        Name: AddTrack
*
* Description: Adds new track to track data base and sorts               
* 
*  Attributes: newTrack
*
*      Return: none
*
*      Author: Nathan Soule
*
******************************************************************************/
void TrackDatabase::AddTrack(Track* newTrack)
{ 
  semaphore.Obtain(Semaphore::WAIT_FOREVER);

    currentTracks.push_back(newTrack);
    sort(currentTracks.begin(),currentTracks.end(),LessThan);

  semaphore.Release();
}

/******************************************************************************
*
*        Name: RemoveFirstTrack
*
* Description: Remove the highest priority track from track database
*              only the highest priority track needs to be removed because 
               any threat that is not the highest priority means it still has
               time remain until arrival
* 
*  Attributes: none
*
*      Return: none
*
*      Author: Nathan Soule
*
******************************************************************************/

void TrackDatabase::RemoveFirstTrack()
{
  semaphore.Obtain(Semaphore::WAIT_FOREVER);

    currentTracks.erase(currentTracks.begin());

  semaphore.Release();
}

/******************************************************************************
*
*        Name: GetFirstTrack
*
* Description: Called by the CM thread, this reports the information about the
*              highest priority threat
* 
*  Attributes: none
*
*      Return: Track*
*
*      Author: Nathan Soule
*
******************************************************************************/
Track* TrackDatabase::GetFirstTrack()
{
  semaphore.Obtain(Semaphore::WAIT_FOREVER);

    if (dbSize() != 0)
      return currentTracks.front();

    // Will return NULL if vector size = 0.

    return NULL;

  semaphore.Release();
}
/******************************************************************************
*
*        Name: dbSize
*
* Description: Returns the size of the data base, only used for code testing              
* 
*  Attributes: none
*
*      Return: long
*
*      Author: Nathan Soule
*
******************************************************************************/

long TrackDatabase::dbSize()
{
  semaphore.Obtain(Semaphore::WAIT_FOREVER);

    return currentTracks.size();

  semaphore.Release();
}
