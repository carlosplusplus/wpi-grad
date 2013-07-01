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

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;
struct rec
{
  //int x,y,z;
  //char buffer[255];
  long length;
  long id;
  long waveform[25];
  long velocity;
  long jamCode;
};

int main()
{
  try
  {
    FILE *inputfile;
    struct rec my_threat;

    inputfile = fopen("threats.bin","r");
    if(!inputfile)
    {
      cout << "Unable to open file!" << endl;
      return 1;
    }
    for(int i = 1; i <= 10; i++)
    {
      cout << "got into for loop" << endl;
      fread(&my_threat, sizeof(struct rec), 1, inputfile);
      cout << my_threat.length << " " << my_threat.id << " " << "ok" << endl;
      
      //printf("%d\n",my_threat.z);
    }
    fclose(inputfile);
    return 0;
  }
  catch (exception &e)
  {
    std::cout << "Error: " << e.what() << "\n";
    return 1;
  }
}