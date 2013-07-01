/***************************************************************
*
* Name:         CSVThreatParser.cpp
*
* Description:  Parser for CSV file input "threats.csv".
* 
* Attributes:   It works
*
* Return:       A Threat Record.
*
* Author:       Gregory Hovagim
*
***************************************************************/

#include "MessageLog.h"
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>
#include "CSVThreatParser.h"

using namespace std;

/***************************************************************
*
* Name:         CSVThreatParser
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

CSVThreatParser::CSVThreatParser(void)
{
}

/***************************************************************
*
* Name:         ~CSVThreatParser
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

CSVThreatParser::~CSVThreatParser(void)
{
}

/***************************************************************
*
* Name:         ReadThreats
*
* Description:  Receives comma separated input file 
*               "threats.csv" and kicks-off ThreatParser.
* 
* Attributes:   filename and threat database
*
* Return:       boolean true/false
*
* Author:       Gregory Hovagim
*
***************************************************************/

bool CSVThreatParser::ReadThreats(string filename, ThreatDatabase* database)
{
  try
  {
    ifstream in(filename.c_str());
    
    if(in.fail())
    {
      return false;
    }

    while(in.good())
    {
      string line;
      string subLine;
      string comma(",");
      getline(in, line);
      int found;

      if(!line.empty())
      {
        int prev = -1;
        found = 0;
        int i = 0;
        long waveform[25];
        float velocity = 1.0;
        int jamCode = 0;

        while(found != string::npos)
        {
          found = line.find(comma, prev+1);

//        extract subline from between comma's
          if (found != string::npos)
          {
//          if not end of line, parse it
            subLine = line.substr( (prev+1), (found-(prev+1)) );
            prev = found;
            
          }
          else
          {
//          you're at the end, deal with it
            subLine = line.substr( (prev+1), ((line.length()-1)-prev));
          }
          
//        keep assembling the threat record
          if(i < 25)
            {
              waveform[i] = atol(subLine.c_str());
            }
            else
            {
              if(i == 25)
              {
                velocity = atof(subLine.c_str());
              }
              else 
              {
                jamCode = atol(subLine.c_str());
              }
            }
          i++;
        }
        database->AddThreat(new Threat(waveform, jamCode, velocity));
      }
    }
   return true;
  }
  catch (exception &e)
  {
//  should use MessageLog class to output error
    std::cout << "Error: " << e.what() << "\n";
    return false;
  }
}