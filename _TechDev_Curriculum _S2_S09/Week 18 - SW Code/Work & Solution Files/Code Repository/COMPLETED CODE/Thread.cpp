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

#include "Thread.h"

  
/******************************************************************************
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
******************************************************************************/
DWORD WINAPI InternalThreadFunction(LPVOID param)
{
  ((Thread*)param)->Run();
  return 0;
}


/******************************************************************************
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
******************************************************************************/
Thread::Thread(void) {}

/******************************************************************************
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
******************************************************************************/
Thread::~Thread(void) {}

/******************************************************************************
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
******************************************************************************/
bool Thread::Start(void)
{
  return (threadHandle = CreateThread(NULL, 
                                      0, 
                                      InternalThreadFunction, 
                                      this, 
                                      0, 
                                      NULL)) == NULL;
}
