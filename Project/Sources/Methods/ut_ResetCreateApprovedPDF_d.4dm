//%attributes = {"invisible":true}
//Method: ut_ResetCreateApprovedPDF_d
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 04/15/21, 15:02:00
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04  //Created to reset dates to !00-00-00!
End if 
//

READ WRITE:C146([Inspections:27])
QUERY:C277([Inspections:27]; [Inspections:27]CreateApprovedPDF_d:218#!00-00-00!)

Repeat 
	APPLY TO SELECTION:C70([Inspections:27]; [Inspections:27]CreateApprovedPDF_d:218:=!00-00-00!)
	If (Records in set:C195("Lockedset")>0)
		USE SET:C118("Lockedset")
		DELAY PROCESS:C323(Current process:C322; 120)
	End if 
	
	
Until (Records in set:C195("Lockedset")=0)
//End ut_ResetCreateApprovedPDF_d