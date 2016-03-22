#include "helper.h"
#include <ctime>

Helper::Helper(QObject *parent) : QObject(parent)
{
}


bool Wait(const unsigned long &Time)
{
    clock_t Tick = clock_t(float(clock()) / float(CLOCKS_PER_SEC) * 1000.f);
    if(Tick < 0) // if clock() fails, it returns -1
        return 0;
    clock_t Now = clock_t(float(clock()) / float(CLOCKS_PER_SEC) * 1000.f);
    if(Now < 0)
        return 0;
    while( (Now - Tick) < Time )
    {
        Now = clock_t(float(clock()) / float(CLOCKS_PER_SEC) * 1000.f);
        if(Now < 0)
            return 0;
    }
    return 1;
}

void Helper::calculate(){
        long int i=999999999;
        while(i>0)
        {
            i--;
        }
}


