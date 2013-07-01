/***************************************************************
*
* Name: TrackDatabase.h
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

#pragma once

#include <algorithm>
#include <iostream>
#include <vector>

#include "Semaphore.h"
#include "Track.h"

using namespace std;

class TrackDatabase
{

private:

  // Declare member variables.

  vector <Track*> currentTracks;
  Semaphore semaphore;

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

  friend bool LessThan(Track*& left, Track*& right);

public:
  
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

  TrackDatabase();

  /***************************************************************
  *
  * Name: AddTrack
  *
  * Description: Add a new Track to the database.
  * 
  * Attributes: Take in a Track* to add into the TrackDatabase.
  *
  * Return: NONE
  *
  * Author: Nathan Soule
  *
  ***************************************************************/

  void   AddTrack(Track*);

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

  void   RemoveFirstTrack();
  Track* GetFirstTrack();
};