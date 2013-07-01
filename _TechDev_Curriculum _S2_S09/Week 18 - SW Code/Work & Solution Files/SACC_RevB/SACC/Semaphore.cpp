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

#include <windows.h>
#include <stdio.h>
#include "Semaphore.h"

/******************************************************************************
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
******************************************************************************/
Semaphore::Semaphore(void):
mutexHandle(NULL)
{}

/******************************************************************************
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
******************************************************************************/
Semaphore::~Semaphore(void)
{
  if (mutexHandle)
  {
    CloseHandle(mutexHandle);
  }
}

/******************************************************************************
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
******************************************************************************/
bool Semaphore::Initialize(void)
{
  return (mutexHandle = CreateMutex(NULL, false, NULL)) != NULL;
}

/******************************************************************************
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
******************************************************************************/
int Semaphore::Obtain(unsigned long waitTime)
{
  DWORD internalWaitTime;

  // Determine the DWORD wait time to provide to the windows mutex interface.
  switch (waitTime)
  {
  case DONT_WAIT:
    internalWaitTime = 0;
    break;

  case WAIT_FOREVER:
    internalWaitTime = INFINITE;
    break;

  default:
    internalWaitTime = (DWORD)waitTime;
  }

  // Wait on the mutex and interpret the return value.
  switch (WaitForSingleObject(mutexHandle, waitTime))
  {
  case WAIT_OBJECT_0:
    return SEMAPHORE_OBTAINED;

  case WAIT_TIMEOUT:
    return SEMAPHORE_TIMEOUT;

  default:
    return SEMAPHORE_ERROR;
  }
}

/******************************************************************************
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
******************************************************************************/
bool Semaphore::Release()
{
  return ReleaseMutex(mutexHandle) != 0;
}