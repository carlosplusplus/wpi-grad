/***************************************************************
*
* Name:         XMLThreatParser.cpp
*
* Description:  This class parses threats received from a file
*               of XML threat data.
*
* Author:       Gregory Hovagim
*
***************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

#include "MessageLog.h"
#include "XMLThreatParser.h"

using namespace std;

/***************************************************************
*
* Name:         XMLThreatParser (constructor)
*
* Description:  Constructs on object of type XMLThreatParser
* 
* Attributes:   NONE.
*
* Return:       NONE.
*
* Author:       Gregory Hovagim
*
***************************************************************/

XMLThreatParser::XMLThreatParser(void)
{
}

/***************************************************************
*
* Name:         ReadThreats
*
* Description:  Receives Extensible Markup Language (xml) file 
*               "threats.xml" and .
* 
* Attributes:   Filename describes the name of the input file.

*
* Return:       bool ->
*
* Author:       Gregory Hovagim
*
***************************************************************/

bool XMLThreatParser::ReadThreats(string filename, ThreatDatabase* database)
{
  try
  {
    // Open the input file passed into ReadThreats.

    ifstream in(filename.c_str());

    // Ensure the file opens correctly.

    if(in.fail())
    {
      return false;
    }

    // Define variables for different string operations.

    string closeStart = "</";
    string line;
    string openEnd = ">";
    string subLine;    
    
    int   found = 0;
    int   i = 0;
    int   jamCode = 0;
    int   lineCount = 1;
    int   prev = -1;
    int   threatcount = 1;
    float velocity = 1.0;
    long  waveform[25];

    // While we can read in lines from the input stream:

    while(getline(in,line))
    {

      // Since the XML is parsing is standard, a line pattern can be seen.
      // Every single 2 + 30x lines, we reach the beginning of a new threat
      // block. Keep track of all the lines in real time.

      if(lineCount == 2 + (threatcount-1) * 30)
      {
        // Increase the threat count. 

        threatcount++;

        // The next 25 lines of code will be the threat information.
        // Read in the threat information into the waveform vector of longs.

        for (int i = 0; i < 25; i++)
        {
          getline(in, line);
          found = line.find(openEnd, prev+1);
          
          // Extract the information from the input string.

          if (found != string::npos)
          {
            subLine = line.substr(13,(line.length() - 25));
            found = 0;
          }

          // Set the current waveform element to the one found.

          waveform[i] = atol(subLine.c_str());
         
          lineCount++;
        }

        // Increment the line count by two and take in the velocity information.

        lineCount = lineCount + 2;

        getline(in, line);
        getline(in, line);
        
        // Extract the velocity data from the current input string.

        subLine = line.substr(11,(line.length() - 22));
        velocity = atof(subLine.c_str());

        lineCount++;

        // Extract the jam code data from the current input string.

        getline(in, line);
        subLine = line.substr(10,(line.length()-20));
        jamCode = atoi(subLine.c_str());

        // Create a Threat based off newly obtained information and 
        // insert it into the ThreatDatabase.

        database->AddThreat(new Threat(waveform, jamCode, velocity));
      }

      // If the current line is not at the beginning of a Threat block,
      // increase the lineCount and continue the parsing loop.

      else 
      {
        lineCount++;
      }
    }

    return true;

  }

  // Print out an error in case the XMLThreadParser does not work.

  catch (exception &e)
  {
    MessageLog::Instance()->LogMessage("XMLThreadParser did not read file correctly");
    return false;
  }
}