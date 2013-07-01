#pragma once
#include <iostream>

class Track
{

private:

  // Declare member variables.

  long  timeOfArrival;
  long  threatID;
  float angleOfArrival;

public:

  // Constructor definition.
  
  Track(long,long,float);

  // Declare member functions.

  long  GetTimeOfArrival();
  long  GetThreatID();
  float GetAngleOfArrival();

};