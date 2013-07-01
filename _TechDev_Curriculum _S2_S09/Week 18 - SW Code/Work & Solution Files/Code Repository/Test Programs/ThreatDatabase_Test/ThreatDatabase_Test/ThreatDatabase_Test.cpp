#include <iostream>
#include <vector>

#include "ThreatDatabase.h"

using namespace std;

int main()
{

  ThreatDatabase threatDB;

  // Make a Threat.

  long wfA[WF_SIZE];
  long wfB[WF_SIZE];
  long wfC[WF_SIZE];
  long wfT[WF_SIZE];

  for (int i = 0; i < WF_SIZE; i++)
  {
    wfA[i] = i;
    wfB[i] = 2*i;
    wfC[i] = 3*i;
    wfT[i] = 4*i;
  }

  int jcA = 100;
  int jcB = jcA * 2;
  int jcC = jcA * 3;

  int tIDA = 1;
  int tIDB = 2;
  int tIDC = 3;
  int tIDT = 4;

  // Create your Threats and add to database.

  Threat* my_ThreatA = new Threat(wfA,jcA,tIDA);
  Threat* my_ThreatB = new Threat(wfB,jcB,tIDB);
  Threat* my_ThreatC = new Threat(wfC,jcC,tIDC);

  threatDB.AddThreat(my_ThreatA);
  threatDB.AddThreat(my_ThreatB);
  threatDB.AddThreat(my_ThreatC);

    cout << "This is the size of my Threat Database: " << threatDB.dbSize() << endl << endl;

  // Test: One = Success, Two = Fail.

  Threat* testWFOne = threatDB.FindThreatByWF(wfA);
  Threat* testWFTwo = threatDB.FindThreatByWF(wfT); // Should return null.

  cout << "ThreatID of testWFOne: " << testWFOne->GetThreatID() << endl << endl;

  if (testWFTwo == NULL)
  {
    cout << "testWFTwo ID NOT found in the ThreatDatabase!" << endl << endl;
  }

  // Test: One = Success, Two = Fail.

  Threat* testIDOne = threatDB.FindThreatByID(tIDB);
  Threat* testIDTwo = threatDB.FindThreatByID(tIDT); // Should return null.

  cout << "ThreatID of testIDOne: " << testIDOne->GetThreatID() << endl << endl;

  if (testWFTwo == NULL)
  {
    cout << "testIDTwo ID NOT found in the ThreatDatabase!" << endl << endl;
  }


  return 0;
}