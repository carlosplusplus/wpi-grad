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

#pragma once

#include "Thread.h"
#include "ThreatDatabase.h"
#include "TrackDatabase.h"

class CMControllerThread :
  public Thread
{
public:

  /****************************************************************************
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
  ****************************************************************************/
  CMControllerThread(ThreatDatabase* threatDatabase, 
                     TrackDatabase* trackDatabase);

  /****************************************************************************
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
  ****************************************************************************/
  ~CMControllerThread(void);

private:
  
  // This maintains if the CM is currently turned on or off.
  bool enabledCM;

  ThreatDatabase* threatDatabase;
  TrackDatabase* trackDatabase;

  /****************************************************************************
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
  ****************************************************************************/
  void Run(void);
};
