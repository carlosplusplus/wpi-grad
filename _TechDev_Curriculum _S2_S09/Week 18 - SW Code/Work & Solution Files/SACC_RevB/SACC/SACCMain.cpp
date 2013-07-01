#include <string>
#include <iostream>

#include "BINThreatParser.h"
#include "CMControllerThread.h"
#include "CSVThreatParser.h"
#include "HeartbeatThread.h"
#include "INUThread.h"
#include "MCCMTransceiver.h"
#include "PlatformOrientation.h"
#include "SensorThread.h"
#include "SystemClock.h"
#include "ThreatDatabase.h"
#include "ThreatParser.h"
#include "TrackDatabase.h"
#include "XMLThreatParser.h"

using namespace std;

/******************************************************************************
*
*        Name: PrintUsage
*
* Description: Prints the usage of the program to stdout.
* 
*  Attributes: None
*
*      Return: None
*
*      Author: Austin Dionne
*
******************************************************************************/
void PrintUsage()
{
  cout << "Usage: \n"
           << "Main SACC.exe [--noheart] <threat-list-filename>\n"
           << "  where:\n"
           << "  --noheart specifies not to start the heartbeat thread. This\n"
           << "    will ignore the heartbeat messages from the MC and not\n"
           << "    send any responses.\n"
           << "  <threat-list-filename> is the name of the file that \n"
           << "    contains the list of threat types in either CSV, binary,\n"
           << "    or XML format. The file extension must be .csv, .bin, or\n"
           << "    .xml accordingly, or the file will not be recognized.\n";
}

/******************************************************************************
*
*        Name: ParseArguments
*
* Description: Parses the command line arguments and reads the specified file
*              to fill the specified threat database. If the arguments were
*              not specified correctly, or the file was not in the correct
*              format, error messages are printed to standard output.
* 
*  Attributes: argc - count of arguments
*              argv - array of C strings representing command line arguments.
*              threatDatabase - pointer to the threat database to fill with
*                threats read in from file.
*              startHeartbeat - boolean returned by reference indicating 
*                whether or not the heartbeat thread should be started.
*
*      Return: True if the arguments were specified correctly and the file was
*                read without error, false otherwise.
*
*      Author: Austin Dionne
*
******************************************************************************/
bool ParseArguments(int argc, 
                    char** argv, 
                    ThreatDatabase* threatDatabase,
                    bool& startHeartbeat)
{
  string filename;

  if (argc == 2)
  {
    startHeartbeat = true;
    filename = string(argv[1]);
  }
  else if (argc == 3)
  {
    if (string(argv[1]) == "--noheart")
    {
      startHeartbeat = false;
      filename = string(argv[2]);
    }
    else
    {
      PrintUsage();
      return false;
    }
  }
  else
  {
    // Invalid number of arguments
    PrintUsage();
    return false;
  }

  if (filename.length() > 4)
  {
    // Using the file extension, determine what type of parser we need to 
    // instantiate.
    string extension = filename.substr(filename.length()-4, 4);
    ThreatParser* threatParser;
    if (extension == ".csv")
    {
      threatParser = new CSVThreatParser();
    }
    else if (extension == ".bin")
    {
      threatParser = new BINThreatParser();
    }
    else if (extension == ".xml")
    {
      threatParser = new XMLThreatParser();
    }
    else
    {
      cout << "Invalid filename: " << filename << "\n"
           << "Filename must end with .csv .bin or .xml!\n";
      return false;
    }

    if (!threatParser->ReadThreats(filename, threatDatabase))
    {
      cout << "Error while parsing threats file!\n";
      return false;
    }
    else
    {
      return true;
    }
  }
  else
  {
    cout << "Invalid filename: " << filename << "\n";
    return false;
  }
}

/******************************************************************************
*
*        Name: main (program entry point)
*
* Description: Initializes the system.
* 
*  Attributes: argc - count of arguments
*              argv - array of C strings representing command line arguments.
*
*      Return: 1 if system fails, 0 otherwise.
*
*      Author: Austin Dionne
*
******************************************************************************/
int main(int argc, char** argv)
{
  bool startHeartbeat;

  // Create the threat and track databases, empty by default.
  TrackDatabase trackDatabase;
  ThreatDatabase threatDatabase;

  // Parse the command line arguments and read in the threats from file.
  if (!ParseArguments(argc, argv, &threatDatabase, startHeartbeat))
  {
    return 1;
  }
  
  // Create the various threads that control the system.
  CMControllerThread threadCMController(&threatDatabase, &trackDatabase);
  INUThread threadINU;
  SensorThread threadSensor(&threatDatabase, &trackDatabase);
  HeartbeatThread threadHeartbeat;
  
  // Initialize the various utilities used in the system.
  TCPSocket::Initialize();
  SystemClock::Instance()->Initialize();
  MCCMTransceiver::Instance()->Initialize();

  // Start each of the system threads.
  threadCMController.Start();
  threadINU.Start();
  threadSensor.Start();

  // It is possible that we do not want to start the heartbeat thread.
  if (startHeartbeat)
  {
    threadHeartbeat.Start();
  }

  // The threads perform all of the system processing. This loop keeps the
  // main program running indefinately so that the threads can do their work.
  while (true)
  {
    Sleep(3600000);
  }

  return 0;
}