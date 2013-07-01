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

#pragma once

// This fault is raised if there was an error communicating over the sensor 
// interface.
#define SENSOR_INTERFACE_FAULT 1

// This fault is raised if there was an error communicating over the INU
// interface.
#define INU_INTERFACE_FAULT    2

// This fault is raised if there was an error communicating with and 
// controlling the CM.
#define CM_CONTROLLER_FAULT    3

// This fault is raised if there was an error while reading/echoing the
// heartbeat to the MC.
#define HEARTBEAT_FAULT        4

// This fault is raised in communication with the MC/CM interface could not
// be established.
#define MC_CM_INTERFACE_FAULT  5

// This constant defines the total number of different faults in the system
#define TOTAL_NUMBER_OF_FAULTS 5

class BITControl
{
public:
    
  /****************************************************************************
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
  ****************************************************************************/
  static BITControl* Instance();
  
  /****************************************************************************
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
  ****************************************************************************/
  void ClearFault(int fault);
  
  /****************************************************************************
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
  ****************************************************************************/
  void RaiseFault(int fault);
 
  /****************************************************************************
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
  ****************************************************************************/
  bool GetSystemBITStatus();

private:

  // Single instance of BITControl that exists in the system.
  static BITControl* instance;

  // This array maintains the current status for each type of fault.
  bool currentBITStatus[TOTAL_NUMBER_OF_FAULTS];
  
  /****************************************************************************
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
  ****************************************************************************/
  BITControl(void);
  
  /****************************************************************************
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
  ****************************************************************************/
  ~BITControl(void);
};
