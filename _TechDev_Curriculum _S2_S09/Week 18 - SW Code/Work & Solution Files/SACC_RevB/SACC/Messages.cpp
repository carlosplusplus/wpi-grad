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
*        Name: FloatToFixed
*
* Description: This function converts a floating point value used within
*              the system to a long fixed point value with a resolution of
*              0.1.
* 
*  Attributes: value - floating point value
*
*      Return: Fixed point value with a resolution of 0.1.
*
*      Author: Austin Dionne
*
****************************************************************************/
long FloatToFixed (float value)
{
  return (long)(value * 10.0f);
}

/****************************************************************************
*
*        Name: FixedToFloat
*
* Description: This function converts a fixed point value with a resolution 
*              of 0.1 into a floating point value.
* 
*  Attributes: value - fixed point value with a resolution of 0.1.
*
*      Return: Floating point value.
*
*      Author: Austin Dionne
*
****************************************************************************/
float FixedToFloat (long value)
{
  return (float)value / 10.0f;
}