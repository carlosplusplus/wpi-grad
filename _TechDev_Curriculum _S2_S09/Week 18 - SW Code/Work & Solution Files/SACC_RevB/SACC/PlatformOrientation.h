/******************************************************************************
*
*    Class: PlatformOrientation
*
*  Purpose: This class maintains a history of the rotation of the platform
*           based on INU data reported to the package via StoreINUData. Using
*           this history the class can return the estimated current position
*           of the platform at any time. This estimation is created using a 
*           single order extrapolation based on the past two datapoints.
*
*           This class acts as a singleton.
*
*           The procedures/functions in this class are thread-safe.
*
*   Author: Austin Dionne
*
******************************************************************************/

#pragma once
#include "Semaphore.h"

class PlatformOrientation
{
public:
  
  /****************************************************************************
  *
  *        Name: Instance
  *
  * Description: Returns the single instance of PlatformOrientation that exists
  *              in the system. The instance is created if it does not yet 
  *              exist.
  * 
  *  Attributes: None
  *
  *      Return: Pointer to the single instance of PlatformOrientation.
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  static PlatformOrientation* Instance();
  
  /****************************************************************************
  *
  *        Name: StoreINUData
  *
  * Description: Reports a new azimuth datapoint to the PlatformOrientation.
  *              It is assumed that this procedure is called immediately when
  *              a new platform azimuth is reported, as it extracts the current
  *              system time in order to timestamp the data.
  * 
  *  Attributes: azimuth - newly reported platform azimuth (in degrees).
  *
  *      Return: None
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  void StoreINUData(float azimuth);
  
  /****************************************************************************
  *
  *        Name: GetCurrentAzimuth
  *
  * Description: Returns the estimated current platform azimuth. This azimuth
  *              was calculated by extrapolating using the previous reported 
  *              INU data.
  * 
  *  Attributes: None
  *
  *      Return: Estimated current platform azimuth (in degrees).
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  float GetCurrentAzimuth(void);
  
  /****************************************************************************
  *
  *        Name: GetCurrentAngularVelocity
  *
  * Description: Returns the estimated current angular velocity of the platform
  *              (in degrees/sec).
  * 
  *  Attributes: None
  *
  *      Return: Estimated current platform angular velocity (in degrees/sec).
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  float GetCurrentAngularVelocity(void);

private:

  // Single instance of PlatformOrientation.
  static PlatformOrientation* instance;

  // Estimated velocity calculated using INU history.
  float currentVelocity;

  // Used to protect the INU history, making this class thread safe.
  Semaphore semaphore;

  /****************************************************************************
  *
  *        Name: PlatformOrientation (constructor)
  *
  * Description: Constructs the platform orientation, initializing the history
  *              and protection semaphore.
  * 
  *  Attributes: None
  *
  *      Return: N/A
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  PlatformOrientation(void);

  /****************************************************************************
  *
  *        Name: PlatformOrientation (destructor)
  *
  * Description: Destructs the platform orientation.
  * 
  *  Attributes: None
  *
  *      Return: N/A
  *
  *      Author: Austin Dionne
  *
  ****************************************************************************/
  ~PlatformOrientation(void);

  // This struct holds a single reported azimuth along with its timestamp 
  // taken when it was reported.
  struct INUDataPoint
  {
    float azimuth;
    double timestamp;
  };

  // This array maintains the a set of the last reported platform azimuth
  // with attached timestamps. It is used to estimate velocity and extrapolate
  // values as the user requests them.
  static const int HISTORY_SIZE = 2;
  struct INUDataPoint history[HISTORY_SIZE];
};
