#include <iostream>
using namespace std;

#include "PlatformOrientation.h"
#include "SystemClock.h"
#include "TestThread.h"

void TestPlatformOrientation()
{
  float currentAzimuth = 0;
  SystemClock::Instance()->Initialize();
  while (true)
  {
    PlatformOrientation::Instance()->StoreINUData(currentAzimuth);
    currentAzimuth += 25.0;

    if (currentAzimuth > 360.0)
    {
      currentAzimuth = 0;
    }
    else if (currentAzimuth < 0.0)
    {
      currentAzimuth = 360.0;
    }

    for (int i=0; i<3; i++)
    {
      Sleep(333);

      cout << "Time: " << SystemClock::Instance()->GetCurrentTime()
        << "\tAz: " << PlatformOrientation::Instance()->GetCurrentAzimuth() 
        << endl;
    }
  }
}

void TestSemaphore()
{
  Semaphore semaphore;
  TestThread testThread(&semaphore);

  semaphore.Initialize();
  semaphore.Obtain(Semaphore::WAIT_FOREVER);
  testThread.Start();
  Sleep(3000);
  semaphore.Release();
  Sleep(3000);
}

int main(int argc, char** argv)
{
  TestPlatformOrientation();
  return 0;
}