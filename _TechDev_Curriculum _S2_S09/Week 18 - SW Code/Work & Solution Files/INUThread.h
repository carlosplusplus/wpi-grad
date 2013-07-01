/******************************************************************************
*
*   Class: INU Thread
*
* Purpose: Creates connection to INU, reads in INU data and stores it to
*          Platform Orientation.
*
*   Author: Nathan Soule
*
******************************************************************************/

#pragma once
#include "Thread.h"
#include "TCPSocket.h"
#include <iostream>
using namespace std;

class INUThread :
  public Thread
{
public:
    /****************************************************************************
  *
  *        Name: INUThread
  *
  * Description: Constructor
  * 
  *  Attributes: none
  *
  *      Return: none
  *
  *      Author: Nathan Soule
  *
  ****************************************************************************/
  INUThread(void);
  /****************************************************************************
  *
  *        Name: ~INUThread
  *
  * Description: Destructor
  * 
  *  Attributes: none
  *
  *      Return: none
  *
  *      Author: Nathan Soule
  *
  ****************************************************************************/
  virtual ~INUThread(void);

    /****************************************************************************
  *
  *        Name: Run
  *
  * Description: Connects socket to INU, recieves messages, sends INU data
  *              to platform orientation
  * 
  *  Attributes: none
  *
  *      Return: none
  *
  *      Author: Nathan Soule
  *
  ****************************************************************************/
  virtual void Run(void);

private:

  TCPSocket socket;
};
