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

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main(int argc, char *argv[])
{
  ifstream in("threats.csv");
  
  if(in.fail())
  {
    cout << "CSV file not found" << endl;
    return 0;
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

        //extract subline from between comma's
        if (found != string::npos)
        {
          //if not end of line, parse it
          subLine = line.substr( (prev+1), (found-(prev+1)) );
          prev = found;
          
        }
        else
        {
          //you're at the end, deal with it
          subLine = line.substr( (prev+1), ((line.length()-1)-prev));
        }
        

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
    }
  }
  return 0;
}