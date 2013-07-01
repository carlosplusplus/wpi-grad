/******************************************************************************
*
* Filename: Messages.h
*
*  Purpose: This file defines the message types used to communicate with the
*           various external interfaces used in system.
*
*   Author: Austin Dionne
*
******************************************************************************/

#pragma once

// These message IDs are used in the message headers for both outgoing and 
// incoming messages used in the system.
#define ALLOCATE_CM_ID      1001
#define TURN_OFF_CM_ID      1002
#define UNKNOWN_THREAT_ID   1003
#define HEARTBEAT_ID        1005
#define THREAT_DETECTION_ID 2001
#define ATTITUDE_MESSAGE    3001

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
long FloatAzimuthToFixed (float azimuth);

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
float FixedAzimuthToFloat (long azimuth);

// This type acts as the header for all messages used in the system. Several
// messages contain no data and consist entirely of this header.
struct MessageHeader
{
  long length;
  long ID;
};

// This message is sent from the SACC to the Counter Measure (CM) in order to
// direct it to the specified azimuth using the specified jam code.
struct AllocateCMData
{
  long azimuth;
  long jamCode;
};

struct AllocateCMMessage
{
  MessageHeader  header;
  AllocateCMData data;
};

// This message is sent from the SACC to the Mission Computer (MC) whenever a
// threat waveform is detected by the sensor that was not recognized.
struct UnknownThreatData
{
  long azimuth;
};

struct UnknownThreatMessage
{
  MessageHeader     header;
  UnknownThreatData data;
};

// This message is sent from the MC to the SACC and then echoed back from the 
// SACC to the MC in order to confirm that communication is still working.
struct HeartbeatData
{
  long count;
};

struct HeartbeatMessage
{
  MessageHeader header;
  HeartbeatData data;
};

// This message is sent from the Sensor to the SACC to alert the system of a 
// newly detected threat waveform.
struct ThreatDetectionData
{
  long waveform[25];
  long azimuth;
  long range;
};

struct ThreatDetectionMessage
{
  MessageHeader       header;
  ThreatDetectionData data;
};

// This message is sent from the Inertial Navigation Unit (INU) to the SACC
// to report the current platform orientation.
struct AttitudeData
{
  long azimuth;
};

struct AttitudeMessage
{
  MessageHeader header;
  AttitudeData  data;
};