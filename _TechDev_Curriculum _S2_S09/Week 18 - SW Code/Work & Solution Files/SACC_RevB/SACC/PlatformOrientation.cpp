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

#include <stdio.h>
#include "PlatformOrientation.h"
#include "SystemClock.h"

#define MAX_DELTA_ANGLE   300.0
#define INVALID_TIMESTAMP -1.0

PlatformOrientation* PlatformOrientation::instance = NULL;

/******************************************************************************
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
******************************************************************************/
PlatformOrientation::PlatformOrientation(void):
currentVelocity(0)
{
  // Initialize history to invalid values.
  for (int i=0; i<HISTORY_SIZE; i++)
  {
    history[i].azimuth = 0;
    history[i].timestamp = INVALID_TIMESTAMP;
  }

  semaphore.Initialize();
}

/******************************************************************************
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
******************************************************************************/
PlatformOrientation::~PlatformOrientation(void)
{}

/******************************************************************************
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
******************************************************************************/
PlatformOrientation* PlatformOrientation::Instance(void)
{
  if (instance == NULL)
  {
    instance = new PlatformOrientation();
  }
  
  return instance;
}

/******************************************************************************
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
******************************************************************************/
void PlatformOrientation::StoreINUData(float azimuth)
{
  semaphore.Obtain(Semaphore::WAIT_FOREVER);
  
  // Push the data back and insert the new data at the front of the history.
  for (int i=0; i<HISTORY_SIZE-1; i++)
  {
    history[i+1].azimuth = history[i].azimuth;
    history[i+1].timestamp = history[i].timestamp;
  }
  history[0].azimuth = azimuth;
  history[0].timestamp = SystemClock::Instance()->GetCurrentTime();

  // If enough history exists, calculate the current angular velocity.
  if (history[1].timestamp != INVALID_TIMESTAMP)
  {
    // Calculate the change in angle between the last two reported azimuth
    float deltaAngle = history[0].azimuth - history[1].azimuth;
    float deltaTime = history[0].timestamp - history[1].timestamp;

    // Check for the both cases of wrap around. When the reported azimuth 
    // changes from say 355 to 5 degrees, the change should be +10 rather
    // than -350. These two checks make the assumption that is a deltaAngle
    // is larger than MAX_DELTA_ANGLE, then it is an indication of 
    // wraparound.
    if (deltaAngle > MAX_DELTA_ANGLE)
    {
      deltaAngle = 360 - deltaAngle;
    }
    else if (deltaAngle < -MAX_DELTA_ANGLE)
    {
      deltaAngle = -360 - deltaAngle;
    }
    currentVelocity = deltaAngle / deltaTime;
  }

  semaphore.Release();
}

/******************************************************************************
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
******************************************************************************/
float PlatformOrientation::GetCurrentAzimuth(void)
{
  double currentAzimuth = 0;
  
  semaphore.Obtain(Semaphore::WAIT_FOREVER);
  if (history[0].timestamp != INVALID_TIMESTAMP)
  {
    // Perform linear interpolation based on the current angular velocity.
    double offset = 0.1;
    double deltaTime = 
      (SystemClock::Instance()->GetCurrentTime() - history[0].timestamp) + offset;
    currentAzimuth = history[0].azimuth + currentVelocity * deltaTime;
  }
  semaphore.Release();

  // Loop the azimuth around if it has run off the valid range.
  if (currentAzimuth > 360.0)
  {
    currentAzimuth = currentAzimuth - 360.0;
  }
  else if (currentAzimuth < 0.0)
  {
    currentAzimuth = currentAzimuth + 360.0;
  }

  return currentAzimuth;
}
  
/******************************************************************************
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
******************************************************************************/
float PlatformOrientation::GetCurrentAngularVelocity(void)
{
  float velocity;
  semaphore.Obtain(Semaphore::WAIT_FOREVER);
  velocity = currentVelocity;
  semaphore.Release();
  return velocity;
}