#ifndef CAPTIVE_PORTAL_H
#define CAPTIVE_PORTAL_H
#include <iostream>
#include <string>
#define PROG_NAME "captiveportal.sh"

using namespace std;
class CaptivePortal{
public:
    CaptivePortal();
    ~CaptivePortal();

    static void launch();
    static void stop();
    static void restart();
    static void reboot();

private:
    static bool is_started;
};
#endif
