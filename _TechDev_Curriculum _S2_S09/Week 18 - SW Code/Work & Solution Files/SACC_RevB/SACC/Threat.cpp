/***************************************************************
*
* Name: Threat.cpp
*
* Description: Threat class defined to keep an active record of
*              all threats read in from the NVSU.     
*
* Author: Carlos Lazo & Nathan Soule
*
***************************************************************/

#include "Threat.h"

/***************************************************************
*
* Name: Threat (constructor)
*
* Description: Constructs object of type Threat given three input values.
* 
* Attributes: long wf[] = waveform of new object
              int jc    = jam code of new object
              float vel = velocity of new object
*
* Return: Defined Threat object.
*
* Author: Carlos Lazo & Nathan Soule
*
***************************************************************/

long Threat::counter = 1;

Threat::Threat(long wf[], int jc, float vel)
{

  // Copy received waveform into object's waveform variable.

  for (int i = 0; i < WAVEFORM_SIZE; i++)
    waveform[i] = wf[i];

  jamCode   = jc;
  velocity  = vel;

  // Assign a private threatID value to each Threat based on a static counter.

  threatID  = counter++;

}

/***************************************************************
*
* Name: GetWaveformSample
*
* Description: Return waveform of the current Threat.
* 
* Attributes: NONE.
*
* Return: -1      -> If index is out of bounds of the waveform.
*         index[i]-> Value at index [i] of the waveform.
*
* Author: Carlos Lazo
*
***************************************************************/

long Threat::GetWaveformSample(int i)
{
  if ((i < 0) || (i > 24))
  {
    return -1;
  }

  return waveform[i];
}

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
* Author: Nathan Soule
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
* Return: Long value of the Threat's threat ID.
*
* Author: Nathan Soule
*
***************************************************************/


long Threat::GetThreatID()
{
  return threatID;
}

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

float Threat::GetVelocity()
{
  return velocity;
}