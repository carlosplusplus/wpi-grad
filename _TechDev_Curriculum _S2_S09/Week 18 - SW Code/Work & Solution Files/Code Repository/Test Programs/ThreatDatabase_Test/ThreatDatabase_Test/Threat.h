/***************************************************************
*
* Name: Threat.h
*
* Description: Header file for the Threat class.
*
* Author: Carlos Lazo & Nate Soule
*
***************************************************************/

#pragma once

#include <iostream>

using namespace std;

// Define a constant for the size of our Threat waveform.

const int WF_SIZE = 25;

class Threat
{

private:

  // Declare private member variables.

  long waveform[WF_SIZE];
  int  jamCode;
  long velocity;

  long threatID;

  static long counter;

public:

  // Constructor definition with 3 variable input.
  
  Threat(long[],int,long);

  // Declare member functions that will return private member variables.

  long*  GetWaveform();
  int    GetJamCode();
  long   GetThreatID();
  long   GetVelocity();

};
