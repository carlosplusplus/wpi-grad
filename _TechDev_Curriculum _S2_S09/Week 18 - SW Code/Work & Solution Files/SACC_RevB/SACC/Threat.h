/***************************************************************
*
* Name: Threat.h
*
* Description: Threat class defined to keep an active record of
*              all threats read in from the NVSU. This is a
*              container class.
*
* Author: Carlos Lazo & Nathan Soule
*
***************************************************************/

#pragma once

#include "Constants.h"

// Define a constant for the size of our Threat waveform.

class Threat
{

private:

  // Declare private member variables.

  long  waveform[WAVEFORM_SIZE];
  int   jamCode;
  float velocity;
  long  threatID;

  // This counter is used to statically assign unique threatIDs to each
  // newly created threat.

  static long counter;

public:

  /***************************************************************
  *
  * Name: Threat (constructor)
  *
  * Description: Constructs object of type Threat given three input values.
  * 
  * Attributes: long wf[] = waveform of new object
  *             int jc    = jam code of new object
  *             float vel = velocity of new object
  *
  * Return: Defined Threat object.
  *
  * Author: Carlos Lazo & Nathan Soule
  *
  ***************************************************************/

  Threat(long waveform[], int jamCode, float velocity);

  /***************************************************************
  *
  * Name: GetWaveformSample
  *
  * Description: Return waveform of the current Threat.
  * 
  * Attributes: NONE.
  *
  * Return: If the index is out of bounds of the waveform, return -1.
  *         Otherwise, return the value at index [i] of the waveform.
  *
  * Author: Carlos Lazo
  *
  ***************************************************************/

  long  GetWaveformSample(int i);

  /***************************************************************
  *
  * Name: GetJamCode
  *
  * Description: Return jam code of the current Threat.
  * 
  * Attributes: NONE
  *
  * Return: Integer value of the threat's jam code.
  *
  * Author: Nate Soule
  *
  ***************************************************************/

  int   GetJamCode();

  /***************************************************************
  *
  * Name: GetThreatID
  *
  * Description: Return threat ID of the current Threat.
  * 
  * Attributes: NONE.
  *
  * Return: Long value of the Threat's threat ID.
  *
  * Author: Nate Soule
  *
  ***************************************************************/
  
  long  GetThreatID();

  /***************************************************************
  *
  * Name: GetVelocity()
  *
  * Description: Return velocity of the current Threat.
  * 
  * Attributes: NONE.
  *
  * Return: Long value of the Threat's velocity.
  *
  * Author: Carlos Lazo
  *
  ***************************************************************/

  float GetVelocity();
  

};