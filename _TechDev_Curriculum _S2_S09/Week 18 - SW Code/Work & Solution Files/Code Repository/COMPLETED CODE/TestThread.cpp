#include "TestThread.h"
#include <iostream>
using namespace std;

TestThread::TestThread(Semaphore* s):
semaphore(s)
{
}

TestThread::~TestThread(void)
{
}

void TestThread::Run(void)
{
  cout << "Obtaining semaphore...";
  if ((semaphore->Obtain(5000)) == Semaphore::SEMAPHORE_OBTAINED)
  {
    cout << "obtained!" << endl;
  }
  else
  {
    cout << "timeout!" << endl;
  }

  while (true)
  {
    cout << "Lol!" << endl;
    Sleep(1000);
  }
}