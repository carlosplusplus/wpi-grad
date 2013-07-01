/******************************************************************************
*
* Filename: Messages.cpp
*
*  Purpose: This file defines the message types used to communicate with the
*           various external interfaces used in system.
*
*   Author: Austin Dionne
*
******************************************************************************/

/****************************************************************************
*
*        Name: FloatAzimuthToFixed
*
* Description: This function converts a floating point azimuth used within
*              the system to a long fixed point azimuth in in increments of
*              0.1 degrees, used by messages.
* 
*  Attributes: azimuth - floating point azimuth in degrees.
*
*      Return: Fixed point azimuth in increments of 0.1 degrees.
*
*      Author: Austin Dionne
*
****************************************************************************/
long FloatAzimuthToFixed (float azimuth)
{
  return (long)(azimuth * 10.0f);
}

/****************************************************************************
*
*        Name: FixedAzimuthToFloat
*
* Description: This function converts a fixed point in in increments of 0.1 
*              degrees used by messages into a floating point azimuth in
*              degrees.
* 
*  Attributes: azimuth - fixed point azimuth in increments of 0.1 degrees.
*
*      Return: Floating point azimuth in degrees.
*
*      Author: Austin Dionne
*
****************************************************************************/
float FixedAzimuthToFloat (long azimuth)
{
  return (float)azimuth / 10.0f;
}