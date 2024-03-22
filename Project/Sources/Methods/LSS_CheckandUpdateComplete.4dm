//%attributes = {"invisible":true}
//Method: LSS_CheckandUpdateComplete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 04/16/15, 10:52:24
	//----------------------------------------------------
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/16/15 10:52:31)
	// Modified by: Costas Manousakis-(Designer)-(2023-07-03 14:09:28)
	Mods_2023_07
	//  `added a check for inspection date not blank and not in the future
End if 
C_TEXT:C284($Message_txt)
$Message_txt:="Current Inspection status = "+\
Choose:C955([LSS_Inspection:164]LSS_Complete_b:39; "Complete"; "Incomplete")+"\n"+\
"Is this Inspection ready to be reviewed?"

CONFIRM:C162($Message_txt; "Not Yet"; "Ready")
If (OK=1)
	If ([LSS_Inspection:164]LSS_Complete_b:39)
		[LSS_Inspection:164]LSS_Complete_b:39:=False:C215
		[LSS_Inspection:164]LSS_CompleteDate_d:40:=!00-00-00!
	End if 
Else 
	// check inspection date 
	
	Case of 
		: ([LSS_Inspection:164]LSS_InspectionDate_d:4=!00-00-00!)  //must be entered
			ALERT:C41("Inspection date has not been entered!\n"+\
				"Inspection will be marked as Incomplete! "+\
				"Please enter the inspection date before marking the report as Complete.")
			[LSS_Inspection:164]LSS_Complete_b:39:=False:C215
			[LSS_Inspection:164]LSS_CompleteDate_d:40:=!00-00-00!
			
		: ([LSS_Inspection:164]LSS_InspectionDate_d:4>Current date:C33)  // cannot be in the future
			ALERT:C41("Inspection date "+String:C10([LSS_Inspection:164]LSS_InspectionDate_d:4)+" is in the future!\n"+\
				"Inspection will be marked as Incomplete! "+\
				"Please correct the inspection date before marking the report as Complete.")
			[LSS_Inspection:164]LSS_Complete_b:39:=False:C215
			[LSS_Inspection:164]LSS_CompleteDate_d:40:=!00-00-00!
		Else 
			If (Not:C34([LSS_Inspection:164]LSS_Complete_b:39))
				[LSS_Inspection:164]LSS_Complete_b:39:=True:C214
				If ([LSS_Inspection:164]LSS_CompleteDate_d:40=!00-00-00!)
					[LSS_Inspection:164]LSS_CompleteDate_d:40:=Current date:C33
				End if 
			End if 
			
	End case 
	
End if 
//End LSS_CheckandUpdateComplete

