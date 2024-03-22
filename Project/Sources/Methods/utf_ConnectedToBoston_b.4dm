//%attributes = {"invisible":true}
//Method: utf_ConnectedToBoston_b
//Description
//  ` Determines whether we are nunning as Client to the Boston Server or to the dev for testing. 
// Parameters
// $0 : $ConnectedToBoston_b
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/21/14, 11:02:56
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
	// Modified by: Costas Manousakis-(Designer)-(9/27/19 15:42:30)
	Mods_2019_09_bug
	//  `dev structure files start with "v_" and end with "MHD BMS"
End if 
//

C_BOOLEAN:C305($0)
C_BOOLEAN:C305($ConnectedToBoston_b)
$ConnectedToBoston_b:=False:C215
If (Application type:C494=4D Remote mode:K5:5)
	
	Case of 
		: (Structure file:C489="MHD BMS.4DC")
			$ConnectedToBoston_b:=True:C214
		: (Structure file:C489="v_@MHD BMS.4DB")
			$ConnectedToBoston_b:=True:C214
	End case 
	
End if 

$0:=$ConnectedToBoston_b
//End utf_ConnectedToBoston