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

#pragma once
#include <windows.h>
#include <stdio.h>

class SystemClock
{
public:

  /****************************************************************************
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
  ****************************************************************************/
  static SystemClock* Instance(void);

  /****************************************************************************
  *
  *        Name: Initialize
  *
  * Description: Initializes the SystemClock to time zero. This procedure must 
  *              be called once before retrieving the time from the 
  *              SystemClock. 
  * 
  *  Attributes: None
  *
  *      Return: None
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  void Initialize(void);

  /****************************************************************************
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
  ****************************************************************************/
  double GetCurrentTime();

private:

  // The single instance of SystemClock
  static SystemClock* instance;

  // Stores the ticksPerSecond specific to the current processor.
  LARGE_INTEGER ticksPerSecond;

  // Stores the number of ticks when the clock is first initialized.
  LARGE_INTEGER startTick;

  /****************************************************************************
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
  ****************************************************************************/
  SystemClock(void);

  /****************************************************************************
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
  ****************************************************************************/
  ~SystemClock(void);
};
