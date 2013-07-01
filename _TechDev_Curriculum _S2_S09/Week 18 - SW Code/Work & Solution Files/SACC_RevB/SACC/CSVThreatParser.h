/***************************************************************
*
* Name:         CSVThreatParser.h
*
* Description:  This class parses threats received from a file
*               of comma separated threat data.
*
* Attributes / Return??
*
* Author:       Gregory Hovagim
*
***************************************************************/

#pragma once
#include "ThreatDatabase.h"
#include "ThreatParser.h"
#include <string>

class CSVThreatParser :
  public ThreatParser
{
public: 

  /****************************************************************************
  *
  *        Name: CSVThreatParser (constructor)
  *
  * Description: Constructs the Comma Separated type CSV Threat Parser.
  * 
  *  Attributes: None
  *
  *      Return: None
  *
  *      Author: Gregory Hovagim
  *
  ****************************************************************************/

  CSVThreatParser(void);

  /****************************************************************************
  *
  *        Name: ~CSVThreatParser (destructor)
  *
  * Description: Deallocates resources allocated for the CSV Threat Parser.
  * 
  *  Attributes: None
  *
  *      Return: None
  *
  *      Author: Gregory Hovagim
  *
  ****************************************************************************/

  ~CSVThreatParser(void);

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