//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_AutoQuit
// User name (OS): charlesmiller
// Date and time: 07/23/09, 11:46:24
// ----------------------------------------------------
// Description
// This method is basically a clone of m_quit to be used to automatically quit clients
//
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2009_07  //r002 `07/23/09, 11:47:35   `Add code to automatically quit all clients
End if 
//TRACE
Shutdown(20)
QUIT 4D:C291
//End ut_AutoQuit M_Quit