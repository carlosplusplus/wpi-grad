// Threat.cpp Implementation File
// Key Contributor: Carlos Lazo

#include <iostream>
#include <vector>

#include "ThreatDatabase.h"

using namespace std;

ThreatDatabase::ThreatDatabase()
{
  // Empty constructor.
}

/***************************************************************
*
* Name: AddThreat
*
* Description: Add a Threat* to the database.
* 
* Attributes: Threat* newThreat = new Threat* to be added to database.
*
* Return: int
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
* Attributes: long checkWF[] = waveform to check against.
*
* Return: Threat*
*
* Author: Carlos Lazo
*
***************************************************************/

Threat* ThreatDatabase::FindThreatByWF(long checkWF[])
{
 semaphore.Obtain(Semaphore::WAIT_FOREVER);

  // Check to see if the ThreatDatabase is empty. If so, ERROR.

  if (knownThreats.size() == 0)
  {
    cout << "ThreatDatabase fails in FindThreatByWF!\n\n";
    return 0;
  }

  // Check to see if you find a waveform match in the vector.

  bool flag = true;
  long currentWF[WF_SIZE] ;

  for (int i = 0; i < knownThreats.size(); i++)
  {
    // Copy current waveform in DB to a local copy.

    for (int j = 0; j < WF_SIZE; j++)
    {
      currentWF[j] = knownThreats[i]->GetWaveform()[j];
    }

    // Check to see if waveforms match. If a mismatch if found, try another Threat.

    for (int k = 0; k < WF_SIZE; k++)
    {
      if (currentWF[k] != checkWF[k])
      {
        k = WF_SIZE;
        flag = false;
      }
    }

    // If flag == true, at this point we know the waveforms match.

    if (flag == true)
      return knownThreats[i];

    // Reset flag variable to iterate across another 

    flag = true;
  }

  // If not found, return a NULL pointer.

  return NULL;
 semaphore.Release();
}

/***************************************************************
*
* Name: FindThreatByID
*
* Description: Sees if a Threat is in the databased based on Threat ID.
* 
* Attributes: long checkID = Threat ID to check against.
*
* Return: Threat*
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
      return knownThreats[i];

  }

  // If not found, return a NULL pointer.

  return NULL;
 semaphore.Release();
}

/***************************************************************
*
* Name: dbSize()
*
* Description: Returns the size of the current ThreatDatabase.
* 
* Attributes: NONE
*
* Return: long
*
* Author: Carlos Lazo
*
***************************************************************/

long ThreatDatabase::dbSize()
{
 semaphore.Obtain(Semaphore::WAIT_FOREVER);

  return knownThreats.size();

 semaphore.Release();
}