//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/07/12, 16:08:05
//----------------------------------------------------
//Method: ut_SetTimeOuts
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r001
	//Modified by: Charles Miller (2/7/12 16:08:06)
	
End if 


If (Structure file:C489="@MHD BMS External@")
	
	Case of   //Force closing network connections before remote firewalls
		: (Application type:C494=4D Remote mode:K5:5)
			SET DATABASE PARAMETER:C642(4D Remote mode timeout:K37:14; 2)  // 2 minutes
			SET DATABASE PARAMETER:C642(Idle connections timeout:K37:51; 60)  // 60 seconds
			SET DATABASE PARAMETER:C642(Idle connections timeout:K37:51; -60)  // 60 seconds
		: (Application type:C494=4D Server:K5:6)
			SET DATABASE PARAMETER:C642(4D Server timeout:K37:13; 10)  // 10 minutes
			SET DATABASE PARAMETER:C642(4D Remote mode timeout:K37:14; 2)  // 2 minutes
			SET DATABASE PARAMETER:C642(Idle connections timeout:K37:51; 60)  // 60 seconds
			SET DATABASE PARAMETER:C642(Idle connections timeout:K37:51; -60)  // 60 seconds
	End case 
	
End if 

//SET DATABASE PARAMETER(82;1)  //quicktime support ?
//End ut_SetTimeOuts