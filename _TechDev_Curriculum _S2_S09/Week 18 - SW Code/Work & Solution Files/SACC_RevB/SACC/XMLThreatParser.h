/***************************************************************
*
* Name:         XMLThreatParser.h
*
* Description:  This class parses threats received from a file
*               of XML threat data.
*
* Author:       Gregory Hovagim
*
***************************************************************/

#pragma once
#include "ThreatDatabase.h"
#include "ThreatParser.h"
#include <string>

class XMLThreatParser :
  public ThreatParser
{
public: 

  /****************************************************************************
  *
  *        Name: XMLThreatParser (constructor)
  *
  * Description: Constructs the Comma Separated type XML Threat Parser.
  * 
  *  Attributes: None
  *
  *      Return: None
  *
  *      Author: Gregory Hovagim
  *
  ****************************************************************************/

  XMLThreatParser(void);

  /****************************************************************************
  *
  *        Name: ReadThreats
  *
  * Description: Takes the filename of the input threat file and 
  *              also receives a pointer to the ThreatDatabase.
  * 
  *  Attributes: Filename of input threat file, pointer to ThreatDatabase.
  *
  *      Return: bool -> Return true if file read worked as intended.
  *
  *      Author: Gregory Hovagim
  *
  ****************************************************************************/

  virtual bool ReadThreats(string filename, ThreatDatabase* database);

};