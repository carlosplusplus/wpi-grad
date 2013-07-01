/******************************************************************************
*
* Filename: Constants.h
*
*  Purpose: This file defines various constants used throughout the system.
*
*   Author: Austin Dionne
*
******************************************************************************/

// This constant defines the number of samples in a threat waveform
#define WAVEFORM_SIZE 25

// This constant defines the number of retry attempts when connecting sockets
// to the various external interfaces.
#define SOCKET_RETRY_ATTEMPTS 60

// This constant defines the amount of delay (in milliseconds) between 
// attempts to connect to the various external interfaces.
#define SOCKET_RETRY_DELAY 1000

// This constant defines a maximum possible length of any message to/from the
// external interfaces. It acts as an upper bound for buffer sizes.
#define MAXIMUM_POSSIBLE_MESSAGE_LENGTH 255

// This is the default delay between countermeasure updates. When the 
// angular velocity of the platform is great enough to produce a significant
// error between updates, this delay is not used.
#define DEFAULT_CM_UPDATE_DELAY 10

// This defines the maximum tolerable error when directing the countermeasure
// (in degrees).
#define MAXIMUM_CM_ERROR_TOLERANCE 1.0