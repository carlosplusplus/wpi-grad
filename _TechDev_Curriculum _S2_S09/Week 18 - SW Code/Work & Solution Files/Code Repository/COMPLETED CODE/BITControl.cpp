/******************************************************************************
*
*    Class: BITControl
*
*  Purpose: This class provides an interface for users to raise and clear 
*           faults. These faults act as indications of failure in various parts
*           of the system. The overall system BIT status depends on which 
*           faults have been reported. A single BIT fault can be enough for the
*           overall system BIT status to be failed.
*
*   Author: Austin Dionne
*
******************************************************************************/

#include "BITControl.h"

BITControl* BITControl::instance = NULL;

/******************************************************************************
*
*        Name: BITControl (constructor)
*
* Description: Constructs the BIT control interface. All faults are cleared
*              by default.
* 
*  Attributes: None
*
*      Return: N/A
*
*      Author: Austin Dionne
*
******************************************************************************/
BITControl::BITControl(void)
{
  for (int i=0; i<TOTAL_NUMBER_OF_FAULTS; i++)
  {
    currentBITStatus[i] = true;
  }
}

/******************************************************************************
*
*        Name: BITControl (destructor)
*
* Description: Deallocates all resources associated to the BITControl object.
* 
*  Attributes: N/A
*
*      Return: N/A
*
*      Author: Austin Dionne
*
******************************************************************************/
BITControl::~BITControl(void)
{

}
  
/******************************************************************************
*
*        Name: Instance
*
* Description: Returns the single instance of BITControl that exists in
*              the system. The instance is created if it does not yet exist.
* 
*  Attributes: None
*
*      Return: Pointer to the single instance of BITControl.
*
*      Author: Austin Dionne
*
******************************************************************************/
BITControl* BITControl::Instance()
{
  if (instance == NULL)
  {
    instance = new BITControl();
  }
  
  return instance;
}

/******************************************************************************
*
*        Name: ClearFault
*
* Description: Clears the specified fault, if it has been previously raised.
* 
*  Attributes: fault - integer fault ID. Constants are defined in the header
*                for this class.
*
*      Return: None
*
*      Author: Austin Dionne
*
******************************************************************************/
void BITControl::ClearFault(int fault)
{
  currentBITStatus[fault] = true;
}

/******************************************************************************
*
*        Name: RaiseFault
*
* Description: Raises the specified fault. Depending on the fault, this may
*              cause the overall system BIT status to be failed.
* 
*  Attributes: fault - integer fault ID. Constants are defined in the header
*                for this class.
*
*      Return: None
*
*      Author: Austin Dionne
*
******************************************************************************/
void BITControl::RaiseFault(int fault)
{
  currentBITStatus[fault] = false;
}

/******************************************************************************
*
*        Name: GetSystemBITStatus
*
* Description: Returns the overall BIT status for the system. Depending on
*              which faults have been raised, the system may be functional
*              or failed.
* 
*  Attributes: None
*
*      Return: True if the system is functional, false if it is failed.
*
*      Author: Austin Dionne
*
******************************************************************************/
bool BITControl::GetSystemBITStatus()
{
  // If any of the key interfaces have failed, then the system has failed.
  return currentBITStatus[SENSOR_INTERFACE_FAULT] &&
         currentBITStatus[INU_INTERFACE_FAULT] &&
         currentBITStatus[CM_CONTROLLER_FAULT] &&
         currentBITStatus[HEARTBEAT_FAULT];
}