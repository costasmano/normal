
//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 10/08/15, 10:46:36
//----------------------------------------------------
//Method: Connect_d.BTN_OK
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// 
	//Modified by: Chuck Miller (10/8/15 10:46:38)
	
End if 

clone_sqlConnect(Username_txt; Password_txt; clone_IPAddress_txt)
If (SQLConnectionMade_b)
	
	ACCEPT:C269
Else 
	Case of 
		: (SQLErrorNumbers_al{1}=1006)
			ALERT:C41("Connection to 4D SQL server not made to IP "+clone_IPAddress_txt+" as 4D Server not running ")
		: (SQLErrorNumbers_al{1}=1003)
			ALERT:C41("Connection to 4D SQL server not made to IP "+clone_IPAddress_txt+" as 4D Server running but SQL Server not started")
		: (SQLErrorNumbers_al{1}=1004)
			ALERT:C41("Connection to 4D SQL server not made to IP "+clone_IPAddress_txt+" as maximum users have already connected")
			
		Else 
			ALERT:C41("Connection to 4D SQL server not made to IP "+clone_IPAddress_txt+" unknown error ")
	End case 
	CONFIRM:C162("connection failed, try again?"; "Yes"; "No")
	If (OK=1)
		SQLError_b:=False:C215
	Else 
		CANCEL:C270
	End if 
End if 
//End Connect_d.BTN_OK

