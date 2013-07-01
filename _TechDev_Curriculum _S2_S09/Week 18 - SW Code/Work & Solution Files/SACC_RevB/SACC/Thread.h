/******************************************************************************
*
*    Class: Thread
*
*  Purpose: This class provides base class for the threads in the system. Each
*           child class must implement the Run() procedure, which will be 
*           called in a separate thread when Start() is called.
*
*   Author: Austin Dionne
*
******************************************************************************/

#pragma once
#include <windows.h>

class Thread
{
public:

  /****************************************************************************
  *
  *        Name: Thread (constructor)
  *
  * Description: Constructs a new Thread object. The Thread is not started
  *              until Start() is called.
  * 
  *  Attributes: None
  *
  *      Return: N/A
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  Thread(void);

  /****************************************************************************
  *
  *        Name: Thread (destructor)
  *
  * Description: Deallocates a Thread object.
  * 
  *  Attributes: None
  *
  *      Return: N/A
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  virtual ~Thread(void);

  /****************************************************************************
  *
  *        Name: Start
  *
  * Description: Starts the thread. The Run() procedure will be called in
  *              the separate thread.
  * 
  *  Attributes: None
  *
  *      Return: True if the Thread was started successfully, false otherwise.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  bool Start();

private:
  HANDLE threadHandle;
  
  /****************************************************************************
  *
  *        Name: Run
  *
  * Description: Performs the function of the thread. This procedure is to be
  *              implemented by the concrete child classes of Thread.
  * 
  *  Attributes: None
  *
  *      Return: N/A
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  virtual void Run(void)=0;
  
  /****************************************************************************
  *
  *        Name: InternalThreadFunction
  *
  * Description: This function matches the prototype necessary for starting
  *              threads using the Windows thread API. It assumes that the
  *              parameter specified is a pointer to a Thread object.
  * 
  *  Attributes: param - pointer to the Threat object that will be started.
  *
  *      Return: Always returns 0.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  friend DWORD WINAPI InternalThreadFunction(LPVOID param);
};
