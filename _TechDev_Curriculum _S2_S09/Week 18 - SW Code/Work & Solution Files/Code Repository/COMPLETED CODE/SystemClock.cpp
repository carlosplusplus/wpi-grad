/******************************************************************************
*
*    Class: SystemClock
*
*  Purpose: This class acts as a clock that can return the amount of time in
*           seconds that has passed since it was first initialized. The 
*           precision of this clock depends on the processor. 
*
*   Author: Austin Dionne
*
******************************************************************************/

#include "SystemClock.h"

SystemClock* SystemClock::instance = NULL;

/******************************************************************************
*
*        Name: SystemClock (Constructor)
*
* Description: Constructs the system clock.
* 
*  Attributes: None
*
*      Return: N/A
*
*      Author: Austin Dionne
*
******************************************************************************/
SystemClock::SystemClock(void)
{}

/******************************************************************************
*
*        Name: SystemClock (Destructor)
*
* Description: Destructs the system clock.
* 
*  Attributes: None
*
*      Return: N/A
*
*      Author: Austin Dionne
*
******************************************************************************/
SystemClock::~SystemClock(void)
{}

/******************************************************************************
*
*        Name: Instance
*
* Description: Returns the single instance of SystemClock that exists in the
*              system. The instance is created if it does not yet exist.
* 
*  Attributes: None
*
*      Return: Pointer to the single instance of SystemClock.
*
*      Author: Austin Dionne
*
******************************************************************************/
SystemClock* SystemClock::Instance(void)
{
  if (instance == NULL)
  {
    instance = new SystemClock();
  }
  
  return instance;
}
  
/******************************************************************************
*
*        Name: Initialize
*
* Description: Initializes the SystemClock to time zero. This procedure must 
*              be called once before retrieving the time from the 
*              SystemClock. 
* 
*  Attributes: None
*
*      Return: N/A
*
*      Author: Austin Dionne
*
******************************************************************************/
void SystemClock::Initialize(void)
{
  // Determine the ticks per second for the current hardware's real time clock.
  QueryPerformanceFrequency(&ticksPerSecond);

  // Get the number of ticks when the clock is first initialized.
  QueryPerformanceCounter(&startTick);
}

/******************************************************************************
*
*        Name: GetCurrentTime
*
* Description: Returns the current system time.
* 
*  Attributes: None
*
*      Return: Time since initialization (in seconds).
*
*      Author: Austin Dionne
*
******************************************************************************/
double SystemClock::GetCurrentTime()
{
  // Query the current number of ticks.
  LARGE_INTEGER currentTick;
  QueryPerformanceCounter(&currentTick);

  // Calculate the time since initialization in seconds.
  return double(currentTick.QuadPart - startTick.QuadPart) / 
           double(ticksPerSecond.QuadPart);
}
