#include <iostream>
#include "Track.h"

// Define constructor.

Track::Track(long TOA, long tID, float AOA)
{
  timeOfArrival = TOA;
  threatID  = tID;
  angleOfArrival = AOA;
}

long Track::GetTimeOfArrival()
{
  return timeOfArrival;
}

long Track::GetThreatID()
{
  return threatID;
}

float Track::GetAngleOfArrival()
{
  return angleOfArrival;
}