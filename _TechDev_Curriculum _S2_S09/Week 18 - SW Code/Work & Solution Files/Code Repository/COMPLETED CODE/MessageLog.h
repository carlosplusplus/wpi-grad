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

#pragma once

#include <string>
#include <iostream>
using namespace std;

class MessageLog
{
public:

  /****************************************************************************
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
  ****************************************************************************/
  static MessageLog* Instance();

  /****************************************************************************
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
  ****************************************************************************/
  void LogMessage(string message);

  /****************************************************************************
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
  ****************************************************************************/
  void EnableOutput(bool enable);

private:

  // Single instance of the MessageLog class.
  static MessageLog* instance;

  // If set to true, messages logged will be output to the user.
  bool outputEnabled;

  /****************************************************************************
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
  ****************************************************************************/
  MessageLog(void);
  
  /****************************************************************************
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
  ****************************************************************************/
  ~MessageLog(void);
};
