/***************************************************************
*
* Name: TrackDatabase.cpp
*
* Description: TrackDatabase class will keep a record of all 
*              active track information in the environment. This
*              information will be used when aiming our CM at any
*              specific target and will ensure that jam priority
*              is maintained based on threat time of arrival.
*
* Author: Nathan Soule
*
***************************************************************/

#include <algorithm>
#include <iostream>
#include <vector>

#include "MessageLog.h"
#include "TrackDatabase.h"

using namespace std;

/***************************************************************
*
* Name: TrackDatabase (constructor)
*
* Description: Constructs object of type TrackDatabase.
* 
* Attributes: NONE
*
* Return: Define new ThrackDatabase object.
*
* Author: Nathan Soule
*
***************************************************************/

TrackDatabase::TrackDatabase()
{
  // Empty constructor
}

/***************************************************************
*
* Name: lessThan
*
* Description: Comparator function to determine which Threat is
*              closer to the SACC. Used to sort TrackDatabase.
* 
* Attributes: NONE
*
* Return: Define new ThrackDatabase object.
*
* Author: Nathan Soule
*
***************************************************************/

bool LessThan(Track*& left, Track*& right)
{
  return left->GetTimeOfArrival() < right->GetTimeOfArrival();
}

/***************************************************************
*
* Name: AddTrack
*
* Description: Add a new Track to the database.
* 
* Attributes: Take in a Track* to add into the TrackDatabase and
*             sorts the list based on Track time of arrival.
*
* Return: NONE
*
* Author: Nathan Soule
*
***************************************************************/

void TrackDatabase::AddTrack(Track* newTrack)
{
  semaphore.Obtain(Semaphore::WAIT_FOREVER);

  currentTracks.push_back(newTrack);

  // Sort the TrackDatabase using the LessThan comparator function.

  sort(currentTracks.begin(),currentTracks.end(),LessThan);

  semaphore.Release();
}

/***************************************************************
*
* Name: RemoveFirstTrack
*
* Description: Remove the first Track in the TrackDatabse when not empty.
* 
* Attributes: NONE
*
* Return: NONE.
*
* Author: Nathan Soule
*
***************************************************************/

void TrackDatabase::RemoveFirstTrack()
{
  semaphore.Obtain(Semaphore::WAIT_FOREVER);

  if (currentTracks.size() == 0)
  {
    MessageLog::Instance()->LogMessage("RemoveFirstTrack in class TrackDatabase detects that the track database is empty!");
  }

  else
  {
    currentTracks.erase(currentTracks.begin());
  }

  semaphore.Release();
}

/***************************************************************
*
* Name: GetFirstTrack()
*
* Description: Called by the CM thread, this reports the information 
*              about the highest priority threat.
* 
* Attributes: NONE
*
* Return: Track* -> Return the first Track in the TrackDatabase.
*           NULL -> If the TrackDatabse is empty.
*
* Author: Nathan Soule
*
***************************************************************/

Track* TrackDatabase::GetFirstTrack()
{
  semaphore.Obtain(Semaphore::WAIT_FOREVER);

  if (currentTracks.size() != 0)
  {
    semaphore.Release();
    return currentTracks.front();
  }

  // Will return NULL if vector size = 0.

  semaphore.Release();

  return NULL;
}
