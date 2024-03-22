//%attributes = {"invisible":true}
//Method: ut_ReturnDestination
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/28/21, 11:37:59
	// ----------------------------------------------------
	//Created : 
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//New method to return destination from Personnel if record if [Preferences]Destination is blank
	//Modified by: Chuck Miller (1/11/22 10:57:26)
	
End if 
//
C_TEXT:C284($0)
ALL RECORDS:C47([Preferences:57])
If ([Preferences:57]Destination:1="")
	ARRAY TEXT:C222($UserNames_atxt; 0)
	ARRAY LONGINT:C221($UserNumber_aL; 0)
	GET USER LIST:C609($UserNames_atxt; $UserNumber_aL)
	C_LONGINT:C283($pos_L)
	$pos_L:=Find in array:C230($UserNames_atxt; Current user:C182)
	If ($pos_L>0)
		QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=$UserNumber_aL{$pos_L})
		$0:=Replace string:C233(String:C10([Personnel:42]Division No:7); "044"; "")
		
	End if 
	
End if 
//End ut_ReturnDestination