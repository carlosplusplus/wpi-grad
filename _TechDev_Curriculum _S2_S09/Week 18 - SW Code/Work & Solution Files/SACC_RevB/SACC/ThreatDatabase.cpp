/***************************************************************
*
* Name: ThreatDatabase.cpp
*
* Description: ThreatDatabase class will keep a record of all 
*              Track information read in from the NVSU. This
*              information will be accessed when searching if
*              the SACC knows how to counter a known Threat.
*
* Author: Carlos Lazo
*
***************************************************************/

#include <iostream>
#include <vector>

#include "Constants.h"
#include "MessageLog.h"
#include "ThreatDatabase.h"

using namespace std;

/***************************************************************
*
* Name: ThreatDatabase (constructor)
*
* Description: Constructs object of type ThreatDatabase.
* 
* Attributes: NONE
*
* Return: Define new ThreatDatabase object.
*
* Author: Carlos Lazo
*
***************************************************************/


ThreatDatabase::ThreatDatabase()
{
  if (!semaphore.Initialize())
  {
    MessageLog::Instance()->
      LogMessage("sendSemaphore initialization failed in ThreatDatabase constructor!");
  }
}

/***************************************************************
*
* Name: AddThreat
*
* Description: Add a new Threat to the database.
* 
* Attributes: Take in a Threat* to add into the ThreatDatabase.
*
* Return: NONE
*
* Author: Carlos Lazo
*
***************************************************************/

void ThreatDatabase::AddThreat(Threat* newThreat)
{
  semaphore.Obtain(Semaphore::WAIT_FOREVER);

  knownThreats.push_back(newThreat);

  semaphore.Release();
}

/***************************************************************
*
* Name: FindThreatByWF
*
* Description: Sees if a Threat is in the databased based on waveform.
* 
* Attributes: checkWF = waveform to check against the ThreatDatabase.
*
* Return: Threat* -> Threat in ThreatDatabase that matches to checkWF.
*
* Author: Carlos Lazo
*
***************************************************************/

Threat* ThreatDatabase::FindThreatByWF(long checkWF[])
{

  semaphore.Obtain(Semaphore::WAIT_FOREVER);

  // Check to see if the ThreatDatabase is empty. If so, print an error to the MessageLog.

  if (knownThreats.size() == 0)
  {
    MessageLog::Instance()->LogMessage("FindThreatByWF in class ThreatDatabase detects that the threat database is empty!");

    semaphore.Release();

    return NULL;
  }

  // Check to see if you find a waveform match in the vector.

  bool flag = true;
  long currentWF[WAVEFORM_SIZE];

  for (int i = 0; i < knownThreats.size(); i++)
  {
    // Copy current waveform in DB to a local copy.

    for (int j = 0; j < WAVEFORM_SIZE; j++)
    {
      currentWF[j] = knownThreats[i]->GetWaveformSample(j);
    }

    // Check to see if waveforms match. If a mismatch if found, try another Threat.

    for (int k = 0; k < WAVEFORM_SIZE; k++)
    {
      if (currentWF[k] != checkWF[k])
      {
        k = WAVEFORM_SIZE;
        flag = false;
      }
    }

    // If flag == true, at this point we know the waveforms match.

    if (flag == true)
    {
      semaphore.Release();

      return knownThreats[i];
    }

    // Reset flag variable to iterate across another 

    flag = true;
  }

  // If not found, return a NULL pointer.
  
  semaphore.Release();

  return NULL;
}

/***************************************************************
*
* Name: FindThreatByID
*
* Description: Sees if a Threat is in the databased based on Threat ID.
* 
* Attributes: checkID = Threat ID to check against.
*
* Return: Threat* -> Threat in ThreatDatabase that matches to checkID.
*
* Author: Carlos Lazo
*
***************************************************************/

Threat* ThreatDatabase::FindThreatByID(long checkID)
{
  semaphore.Obtain(Semaphore::WAIT_FOREVER);

  // Check to see if you find an ID match in the vector.

  bool flag = true;

  for (int i = 0; i < knownThreats.size(); i++)
  {
    if (knownThreats[i]->GetThreatID() == checkID)
    {
      semaphore.Release();

      return knownThreats[i];
    }
  }

  // If not found, return a NULL pointer.

  semaphore.Release();

  return NULL;
}