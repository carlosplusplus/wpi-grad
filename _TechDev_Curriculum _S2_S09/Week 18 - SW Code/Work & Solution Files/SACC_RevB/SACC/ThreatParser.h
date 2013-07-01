#pragma once

#include <string>

#include "ThreatDatabase.h"


class ThreatParser
{
public: 
  
  /****************************************************************************
  *
  *        Name: ThreatParser (constructor)
  *
  * Description: Constructs the type of Threat Parser.
  * 
  *  Attributes: None
  *
  *      Return: None
  *
  *      Author: Gregory Hovagim
  *
  ****************************************************************************/

  ThreatParser(void);

  /****************************************************************************
  *
  *        Name: ThreatParser (constructor)
  *
  * Description: Deallocates resources allocated for the Threat Parser.
  * 
  *  Attributes: None
  *
  *      Return: None
  *
  *      Author: Gregory Hovagim
  *
  ****************************************************************************/

  ~ThreatParser(void);

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

  virtual bool ReadThreats(string filename, ThreatDatabase* database) = 0;

};

