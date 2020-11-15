#include "../include/CaptivePortal.h"
bool CaptivePortal::is_started = false;
string CaptivePortal::command = string(PROG_PATH) + "/" + string(PROG_NAME);
string CaptivePortal::iptables_bak = string(PROG_PATH) + "/" + string(IPTABLES_FILE_BACKUP);

void CaptivePortal::backupRules(){
	// Save the previous rules of the iptables
	system(string("iptables-save > " + CaptivePortal::iptables_bak).c_str());
	cout << "Iptables backup" << endl;
}

void CaptivePortal::restoreRules(){
	// Restore the previous rules of the iptables
	system(string("iptables-restore " + CaptivePortal::iptables_bak).c_str());
	cout << "Iptables restored" << endl;
}

CaptivePortal::CaptivePortal(){
	
}

CaptivePortal::~CaptivePortal(){
	
}

void CaptivePortal::launch(){
	// This script will launch the captive portal
	// and initializing iptables rules
	if(!CaptivePortal::is_started){
		// system(string(CaptivePortal::command + " flush").c_str());
		system(string(CaptivePortal::command + " start").c_str());
		is_started = true;
	}
	else{
		std::cout << "Service already started" << std::endl;
	}
	
}

void CaptivePortal::stop(){
	if(is_started){
		system(string(command + " stop").c_str());
		is_started = false;
	}
	else {
		std::cout << "Service already stopped" << std::endl<< std::endl;
	}
}

void CaptivePortal::restart(){
	std::cout << "Restart called " << std::endl;
	system(string(command + " restart").c_str());
}

void CaptivePortal::reboot(){
	system(string(command + " reboot").c_str());
}