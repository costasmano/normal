If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/1/2005 13:56:07)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/2/2005 18:01:18)
	Mods_2005_CM19
	Mods_2005_CM21
	// Modified by: costasmanousakis-(Designer)-(2/18/09 12:47:09)
	Mods_2009_CM_5404
	//Added a variable help message for the ReadWriteBtn
	// Modified by: costasmanousakis-(Designer)-(3/26/09 15:46:56)
	Mods_2009_03
	//Fixed the SET ENTERABLE(*;"@Cons_@";True) statement for the new WorkHours version
End if 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (WKHR_LockEstimate)
			//Set to read write
			WKHR_LockEstimate:=False:C215
			OBJECT SET ENTERABLE:C238(*; "@Cons_@"; True:C214)
			OBJECT SET ENABLED:C1123(*; "ClearWKHRAllBtn@"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "DeleteRowBtn"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "AddToList"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "ToolSetButton"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			Self:C308->:=0
			WK_EnableEditMsg_s:="Click to Stop Editing Proposal"
			//BUTTON TEXT(Self->;"Set to Read Only")
		Else 
			//Set to read only
			WKHR_LockEstimate:=True:C214
			OBJECT SET ENTERABLE:C238(*; "@Cons_@"; False:C215)
			OBJECT SET ENABLED:C1123(*; "ClearWKHRAllBtn@"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "DeleteRowBtn"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "AddToList"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			OBJECT SET ENABLED:C1123(*; "ToolSetButton"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
			Self:C308->:=1
			WK_EnableEditMsg_s:="Click to Edit/Configure Proposal"
			//BUTTON TEXT(Self->;"Set to Read Write")
		End if 
		
End case 