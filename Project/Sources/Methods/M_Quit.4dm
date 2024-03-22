//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: M_Quit
	//ACI University Programming Classes
	//Created by Jim Steinman
	//Date: 10/1/95.
	
	//Purpose: This procedure quits the database
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
	//Modified: 10/5/95
	<>fK_Wilbur:=False:C215
	Mods_2009_07  //r002 `07/23/09, 13:23:16   `Add code to automatically quit all clients
End if 

C_LONGINT:C283($viNumWindows; $viAppType)  //Command Replaced was o_C_INTEGER
$viNumWindows:=Size of array:C274(<>aiWindows)
$viAppType:=Application type:C494
If (($viNumWindows>1) & ($viAppType#4D Remote mode:K5:5))
	C_TEXT:C284($msg)  // Command Replaced was o_C_STRING length was 255
	$msg:="You are about to exit MHD BMS. "
	$msg:=$msg+"Please make sure all data input screens are closed!."
	CONFIRM:C162($msg; "CANCEL"; "Quit BMS")
Else 
	OK:=0
End if 
If (OK=0)
	ON ERR CALL:C155("")
	ON EVENT CALL:C190("")
	
	If (<>LBackground>0)
		If (<>LBackground=1)
			CONFIRM:C162("There is a background process running.  Quit when it is finished?")
		Else 
			CONFIRM:C162("There are background processes running.  Quit when they are finished?")
		End if 
		
		If (OK=1)
			Repeat 
				G_TickDelay(240)
			Until (<>LBackground=0)
			Shutdown(100)
		End if 
		
	Else 
		Shutdown(100)
	End if 
	
	QUIT 4D:C291
End if 