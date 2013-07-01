#pragma once
#include "Thread.h"

class HeartbeatThread :
  public Thread
{
public:
  HeartbeatThread();
  virtual ~HeartbeatThread(void);
  virtual void Run(void);
};
