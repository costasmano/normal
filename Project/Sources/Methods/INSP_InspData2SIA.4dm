//%attributes = {"invisible":true}
// Method: INSP_InspData2SIA
// Description
// Transfer inspection data to SIA table
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/29/07, 12:51:49
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(2/7/12 15:20:53)
	Mods_2012_02
	//  `Fix for leaving the bridge record unloaded.
	// Modified by: Costas Manousakis-(Designer)-(6/14/13 14:17:25)
	Mods_2013_06
	//  `Added case for Tunnel All items TAL and Overhead items TOV inspections.
End if 
C_TEXT:C284($msg)
Case of 
	: (([Inspections:27]Insp Type:6="RT@") | ([Inspections:27]Insp Type:6="CUL"))  //Routine Inspection
		//save related data to BIN
		QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
		$msg:="Approving a "+[Inspection Type:31]Description:2+" inspection - Saving data to NBI Record BIN : "
		$msg:=$msg+[Bridge MHD NBIS:1]BIN:3+" BDEPT : "+[Bridge MHD NBIS:1]BDEPT:1
		ALERT:C41($msg)
		G_RoutinetoBMS  //NBI record saved in this method
		
		If (Not:C34(Is record loaded:C669([Bridge MHD NBIS:1])))
			LOAD RECORD:C52([Bridge MHD NBIS:1])
		End if 
	: (([Inspections:27]Insp Type:6="TAL") | ([Inspections:27]Insp Type:6="TOV"))  //Tunnel All items or Overhead
		TNL_InspData2Tunnel
		
	Else 
		$msg:="Automatic data transfer to the Record for "+[Inspection Type:31]Description:2+" Inspections is in development."
		$msg:=$msg+<>sCR+"Please enter appropriate SIA data manually."
		ALERT:C41($msg)
End case 