//%attributes = {"invisible":true}
//Method: Bridge_ControlCopyBINRquest
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 09/24/19, 13:39:28
	// ----------------------------------------------------
	//Created : 
	Mods_2019_09  //Add new menu option to copy BIN request It replaces button on form
	//Modified by: Chuck Miller (9/24/19 13:54:41) 
	// Modified by: Costas Manousakis-(Designer)-(2023-04-10 12:22:07)
	Mods_2023_04
	//  `set table to Read only and re-set at the end.
End if 
//
If (Records in set:C195("UserSet")=1)
	C_BOOLEAN:C305($ROStatus_b)
	$ROStatus_b:=Read only state:C362([Bridge MHD NBIS:1])
	READ ONLY:C145([Bridge MHD NBIS:1])
	COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "TempNSel")
	USE SET:C118("UserSet")
	
	Bridge_CopyBinRequest
	USE NAMED SELECTION:C332("TempNSel")
	CLEAR NAMED SELECTION:C333("TempNSel")
	
	If (Not:C34($ROStatus_b))
		READ WRITE:C146([Bridge MHD NBIS:1])
	End if 
	
	POST OUTSIDE CALL:C329(Current process:C322)
Else 
	If (Records in set:C195("UserSet")=0)
		ALERT:C41("you must select a record to proceed")
	Else 
		ALERT:C41("you can only select one record at a time")
		
	End if 
	
End if 
//End Bridge_ControlCopyBINRquest