// Threat.cpp Implementation File
// Key Contributor: Nathan Soule

#include <iostream>

#include "Threat.h"

using namespace std;

long Threat::counter = 1;

/***************************************************************
*
* Name: Threat (constructor)
*
* Description: Constructs object of type Threat given three input values.
* 
* Attributes: long wf[] =  waveform of new object
              int jc    =  jam code of new object
              long tID  = threat ID of new object
*
* Return: new Threat object
*
* Author: Nathan Soule
*
***************************************************************/

Threat::Threat(long wf[], int jc, long vel)
{

  for (int i = 0; i < WF_SIZE; i++)
    waveform[i] = wf[i];

  jamCode   = jc;
  velocity  = vel;
  threatID  = counter++;
}

/***************************************************************
*
* Name: GetWaveform
*
* Description: Return waveform of the current Threat.
* 
* Attributes: NONE.
*
* Return: long*
*
* Author: Nate Soule
*
***************************************************************/


long* Threat::GetWaveform()
{
  return waveform;
}

/***************************************************************
*
* Name: GetJamCode
*
* Description: Return jam code of the current Threat.
* 
* Attributes: NONE
*
* Return: int
*
* Author: Nate Soule
*
***************************************************************/


int Threat::GetJamCode()
{
  return jamCode;
}

/***************************************************************
*
* Name: GetThreatID
*
* Description: Return threat ID of the current Threat.
* 
* Attributes: NONE.
*
* Return: long
*
* Author: Nate Soule
*
***************************************************************/


long Threat::GetThreatID()
{
  return threatID;
}

/***************************************************************
*
* Name: GetVelocity
*
* Description: Return velocity of the current Threat.
* 
* Attributes: NONE.
*
* Return: long
*
* Author: Nate Soule
*
***************************************************************/


long Threat::GetVelocity()
{
  return velocity;
}