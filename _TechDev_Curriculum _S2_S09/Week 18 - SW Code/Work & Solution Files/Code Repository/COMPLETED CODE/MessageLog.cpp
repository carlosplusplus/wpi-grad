/******************************************************************************
*
*    Class: MessageLog
*
*  Purpose: This class provides an interface for printing messages to the 
*           system user. Message output can be enabled/disabled.
*
*   Author: Austin Dionne
*
******************************************************************************/

#include "MessageLog.h"
#include <iostream>
using namespace std;

MessageLog* MessageLog::instance = NULL;

/******************************************************************************
*
*        Name: MessageLog (constructor)
*
* Description: Constructs the message log with output enabled by default.
* 
*  Attributes: Message to log/display.
*
*      Return: None
*
*      Author: Austin Dionne
*
******************************************************************************/
MessageLog::MessageLog(void):
outputEnabled(true)
{}
  
/******************************************************************************
*
*        Name: MessageLog (destructor)
*
* Description: Deallocates resources attributed to the MessageLog.
* 
*  Attributes: None
*
*      Return: None
*
*      Author: Austin Dionne
*
******************************************************************************/
MessageLog::~MessageLog(void)
{}

/******************************************************************************
*
*        Name: Instance
*
* Description: Returns the single instance of MessageLog that exists in the
*              system. The instance is created if it does not yet exist.
* 
*  Attributes: None
*
*      Return: Pointer to the single instance of MessageLog.
*
*      Author: Austin Dionne
*
******************************************************************************/
MessageLog* MessageLog::Instance()
{
  if (instance == NULL)
  {
    instance = new MessageLog();
  }
  
  return instance;
}

/******************************************************************************
*
*        Name: LogMessage
*
* Description: Logs the specified message and displays it to the user if
*              output is enabled.
* 
*  Attributes: Message to log/display.
*
*      Return: None
*
*      Author: Austin Dionne
*
******************************************************************************/
void MessageLog::LogMessage(string message)
{
  cout << ">>> " << message << endl;
}

/******************************************************************************
*
*        Name: EnableOutput
*
* Description: Enables/disables message log output.
* 
*  Attributes: Message to log/display.
*
*      Return: None
*
*      Author: Austin Dionne
*
******************************************************************************/
void MessageLog::EnableOutput(bool enable)
{
  outputEnabled = enable;
}