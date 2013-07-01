/***************************************************************
*
* Name:         BINThreatParser.cpp
*
* Description:  Parser for BIN file input "threats.bin".
* 
* Attributes:   It works.
*
* Return:       A Threat Record.
*
* Author:       Gregory Hovagim
*
***************************************************************/

#include "Messages.h"
#include "BINThreatParser.h"
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

struct rec
{//the vars in the struct must be in the right order
  //int x,y,z;
  //char buffer[255];
  long length;
  long id;
  long waveform[25];
  long velocity;
  long jamCode;
};

/***************************************************************
*
* Name:         BINThreatParser
*
* Description:  
* 
* Attributes:   
*
* Return:       
*
* Author:       Gregory Hovagim
*
***************************************************************/

BINThreatParser::BINThreatParser(void)
{
}

/***************************************************************
*
* Name:         ~BINThreatParser
*
* Description:  
* 
* Attributes:   
*
* Return:       
*
* Author:       Gregory Hovagim
*
***************************************************************/

BINThreatParser::~BINThreatParser(void)
{
}

/***************************************************************
*
* Name:         ReadThreats
*
* Description:  Receives binary input file "threats.bin" and 
*               kicks-off ThreatParser.
* 
* Attributes:   filename and threat database
*
* Return:       boolean true/false
*
* Author:       Gregory Hovagim
*
***************************************************************/
bool BINThreatParser::ReadThreats(string filename, ThreatDatabase* database)
{
  try
  {
    FILE *inputfile;
    struct rec my_threat;

    inputfile = fopen("threats.bin","r");
    
//  when the input file is unable to open
    if(!inputfile)
    {
//    should use MessageLog class to output error
      cout << "Unable to open file!" << endl;
      return false;
    }
    bool reading = true;
    while(reading)
    {
//    should use MessageLog class to output success
      reading = (fread(&my_threat, sizeof(struct rec), 1, inputfile) == 1);
      if (reading)
      {
        database->AddThreat(new Threat(my_threat.waveform, my_threat.jamCode, my_threat.velocity));
      }
    }
    fclose(inputfile);
    return true;
  }
  catch (exception &e)
  {
//  should use MessageLog class to output error
    std::cout << "Error: " << e.what() << "\n";
    return false;
  }
}