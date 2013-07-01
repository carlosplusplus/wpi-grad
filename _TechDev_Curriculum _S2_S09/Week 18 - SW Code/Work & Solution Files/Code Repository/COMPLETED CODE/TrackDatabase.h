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

  Semaphore semaphore;
  vector <Track*> currentTracks;

  friend bool LessThan(Track* left, Track* right);

public:

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
  
  TrackDatabase();

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
  void   AddTrack(Track*);

  /******************************************************************************
*
*        Name: RemoveFirstTrack
*
* Description: Remove the highest priority track from track database
*              only the highest priority track needs to be removed because 
               any threat that is not the highest priority means it still has
               time remaining until arrival
* 
*  Attributes: none
*
*      Return: none
*
*      Author: Nathan Soule
*
******************************************************************************/
  void   RemoveFirstTrack();

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
  Track* GetFirstTrack();

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
  long   dbSize();

};