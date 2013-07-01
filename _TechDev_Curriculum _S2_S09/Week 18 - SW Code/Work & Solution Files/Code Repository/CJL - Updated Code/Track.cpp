/***************************************************************
*
* Name: Track.cpp
*
* Description: Track class defined to keep an active record of
*              all active tracks in the environment. This is a
*              container class.
*
* Author: Nathan Soule
*
***************************************************************/

#include <iostream>

#include "Track.h"

/***************************************************************
*
* Name: Track (constructor)
*
* Description: Constructs object of type Track given three input values.
* 
* Attributes: double TOA = Time of Arrival of the new object.
              long   tID = Threat ID of the new object
              float  AOA = Angle of Arrival of the new object.
*
* Return: Defined Track object.
*
* Author: Nathan Soule
*
***************************************************************/

Track::Track(double TOA, long tID, float AOA)
{
  timeOfArrival = TOA;
  threatID  = tID;
  angleOfArrival = AOA;
}

/***************************************************************
*
* Name: GetTimeOfArrival
*
* Description: Return time of arrival of the current Track.
* 
* Attributes: NONE
*
* Return: Double value of the track's time of arrival.
*
* Author: Nathan Soule
*
***************************************************************/

double Track::GetTimeOfArrival()
{
  return timeOfArrival;
}

/***************************************************************
*
* Name: GetThreatID
*
* Description: Return threat ID of the current Track.
* 
* Attributes: NONE
*
* Return: Long value of the track's threat ID.
*
* Author: Nathan Soule
*
***************************************************************/

long Track::GetThreatID()
{
  return threatID;
}

/***************************************************************
*
* Name: GetAngleOfArrival
*
* Description: Return angle of arrival of the current Track.
* 
* Attributes: NONE
*
* Return: Float value of the track's angle of arrival.
*
* Author: Nathan Soule
*
***************************************************************/

float Track::GetAngleOfArrival()
{
  return angleOfArrival;
}