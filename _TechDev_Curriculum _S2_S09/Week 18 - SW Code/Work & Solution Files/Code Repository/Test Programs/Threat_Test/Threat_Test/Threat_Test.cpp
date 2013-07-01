#include <iostream>
#include "Threat.h"

using namespace std;

int main()
{

  long wf[WF_SIZE];

  for (int i = 0; i < WF_SIZE; i++)
    wf[i] = i;

  /* DEBUG TEST

  for (int i = 0; i < WF_SIZE; i++)
    cout << wf[i] << " ";
  
  */

  int jc  = 5;
  int tID = 7;

  // ... get info from parser for one threat.

  Threat my_Threat(wf,jc,tID);

  cout << "Here is my_Threat's jam code: " << my_Threat.GetJamCode() << endl << endl;

  cout << "Here is my_Threat's Threat ID: " << my_Threat.GetThreatID() << endl << endl;

  long* my_wf = my_Threat.GetWaveform();

  cout << "This is the waveform of my_Threat:\n" << endl;

  for (int i = 0; i < WF_SIZE; i++)
    cout << my_wf[i] << " ";

  cout << endl << endl;

  return 0;
}