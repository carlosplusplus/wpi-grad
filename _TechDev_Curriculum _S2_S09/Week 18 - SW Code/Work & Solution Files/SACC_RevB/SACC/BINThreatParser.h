/***************************************************************
*
* Name:         BINThreatParser.h
*
* Description:  This class parses threats received from a file
*               of binary threat data.
*
* Author:       Gregory Hovagim
*
***************************************************************/

#pragma once

#include "ThreatDatabase.h"
#include "ThreatParser.h"
#include <string>

class BINThreatParser :
  public ThreatParser
{
public: 

  /****************************************************************************
  *
  *        Name: BINThreatParser (constructor)
  *
  * Description: Constructs the Binary type Threat Parser.
  * 
  *  Attributes: None
  *
  *      Return: None
  *
  *      Author: Gregory Hovagim
  *
  ****************************************************************************/
  BINThreatParser(void);
  
  /****************************************************************************
  *
  *        Name: ~BINThreatParser (destructor)
  *
  * Description: Deallocates resources allocated for the Binary Threat Parser.
  * 
  *  Attributes: None
  *
  *      Return: None
  *
  *      Author: Gregory Hovagim
  *
  ****************************************************************************/
  
  ~BINThreatParser(void);

  /****************************************************************************
  *
  *        Name: ReadThreats
  *
  * Description: Takes the filename of the input threat file and 
  *              also receives a pointer to the threat database.
  * 
  *  Attributes: filename of input threat file, pointer to threat database
  *
  *      Return: ???????????????? its virtual...
  *
  *      Author: Gregory Hovagim
  *
  ****************************************************************************/

  virtual bool ReadThreats(string filename, ThreatDatabase* database);

};