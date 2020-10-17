#include "../include/CaptivePortal.h"
bool CaptivePortal::is_started = false;

CaptivePortal::CaptivePortal(){
}

CaptivePortal::~CaptivePortal(){

}

void CaptivePortal::launch(){
	// This script will launch the captive portal
	// and initializing iptables rules
	// std::cout << "Launch called " << std::endl;
	// std::string cmd = "./" + string(PROG_NAME);
	// cmd += " start";
	if(!CaptivePortal::is_started){
		system(string("./" + string(PROG_NAME) + " start").c_str());
		is_started = true;
	}
	else{
		std::cout << "Service already started" << std::endl;
	}
	
}

void CaptivePortal::stop(){
	// std::cout << "Stop called " << std::endl;
	// std::string cmd = "./" + string(PROG_NAME);
	// cmd += " stop";
	if(is_started){
		system(string("./" + string(PROG_NAME) + " stop").c_str());
		is_started = false;
	}
	else {
		std::cout << "Service already stopped" << std::endl<< std::endl;
	}
}

void CaptivePortal::restart(){
	std::cout << "Restart called " << std::endl;
	system(string("./" + string(PROG_NAME) + " restart").c_str());
}

void CaptivePortal::reboot(){
	system(string("./" + string(PROG_NAME) + " reboot").c_str());
}