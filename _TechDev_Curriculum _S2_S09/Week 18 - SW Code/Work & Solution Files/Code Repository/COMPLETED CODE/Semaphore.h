/******************************************************************************
*
*    Class: Semaphore
*
*  Purpose: This class provides a simple binary semaphore that can be used
*           for synchronization between threads.
*
*   Author: Austin Dionne
*
******************************************************************************/

#pragma once
#include <windows.h>

class Semaphore
{
public:

  // Constant values used for waitTime in Obtain()
  static const long DONT_WAIT    = 0;
  static const long WAIT_FOREVER = -1;

  // Return values for Obtain()
  static const int SEMAPHORE_TIMEOUT  = 0;
  static const int SEMAPHORE_OBTAINED = 1;
  static const int SEMAPHORE_ERROR    = 2;

  /****************************************************************************
  *
  *        Name: Semaphore (constructor)
  *
  * Description: Constructs a new Semaphore object. This Semaphore is not
  *              initialized by default.
  * 
  *  Attributes: None
  *
  *      Return: N/A
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  Semaphore(void);

  /****************************************************************************
  *
  *        Name: Semaphore (destructor)
  *
  * Description: Releases the handle to the semaphore.
  * 
  *  Attributes: None
  *
  *      Return: N/A
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  ~Semaphore(void);

  /****************************************************************************
  *
  *        Name: Initialize
  *
  * Description: Initializes a Semaphore object. This procedure must be called
  *              before using the Semaphore, or behavior will be undefined.
  * 
  *  Attributes: None
  *
  *      Return: True if the initialization was successful, false otherwise.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  bool Initialize(void);

  /****************************************************************************
  *
  *        Name: Obtain
  *
  * Description: Obtains the Semaphore. This operation may block if the 
  *              Semaphore is currently held by another thread.
  * 
  *  Attributes: waitTime - time (in milliseconds) to wait for the semaphore to
  *                be obtained. A waitTime of DONT_WAIT can be specified to
  *                not wait, or WAIT_FOREVER can be specified to wait 
  *                indefinitely.
  *
  *      Return: int status defined by constants in this package:
  *                OBTAINED - returned if the semaphore was obtained 
  *                  successfully.
  *                TIMEOUT - returned in the specified waitTime expired before
  *                  obtaining the semaphore.
  *                ERROR - returned if any other error prevented the obtaining
  *                  of the Semaphore.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  int Obtain(unsigned long waitTime);
  
  /****************************************************************************
  *
  *        Name: Release
  *
  * Description: Releases the Semaphore, making it available to be obtained 
  *              by another thread.
  * 
  *  Attributes: None
  *
  *      Return: True if successful, false otherwise.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  bool Release(void);

private:
  HANDLE mutexHandle;
    
};
