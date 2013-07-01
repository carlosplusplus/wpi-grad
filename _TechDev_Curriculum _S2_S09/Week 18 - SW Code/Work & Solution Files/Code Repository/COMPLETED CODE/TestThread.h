#pragma once
#include "Thread.h"
#include "Semaphore.h"

class TestThread :
  public Thread
{
public:
  TestThread(Semaphore* s);
  virtual ~TestThread(void);
  virtual void Run(void);
private:
  Semaphore* semaphore;
};
