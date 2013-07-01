/***************************************************************
*
* Name: ThreatDatabase.h
*
* Description: ThreatDatabase class will keep a record of all 
*              Track information read in from the NVSU. This
*              information will be accessed when searching if
*              the SACC knows how to counter a known Threat.
*
* Author: Carlos Lazo
*
***************************************************************/

#pragma once

#include <iostream>
#include <vector>

#include "Semaphore.h"
#include "Threat.h"

using namespace std;

class ThreatDatabase
{

private:

  // Declare private member variables.

  Semaphore semaphore;
  vector <Threat*> knownThreats;

public:

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
  
  ThreatDatabase();

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

  void AddThreat(Threat*);

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

  Threat* FindThreatByWF(long[]);

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

  Threat* FindThreatByID(long);
};

