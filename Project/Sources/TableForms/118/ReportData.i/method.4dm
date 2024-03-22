// ----------------------------------------------------
// Form Method: ReportData.i
// User name (OS): cjmiller
// Date and time: 01/20/06, 13:44:16
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //05/03/07, 16:12:14`Add new modified by fields
	Mods_2007_CJMv2  //r060   `05/16/07, 15:09:09` `Add code to control access 
	// Modified by: costasmanousakis-(Designer)-(10/29/2007 09:01:21)
	Mods_2007_CM12_5302  // set curr date as received for new records
	// Modified by: costasmanousakis-(Designer)-(10/8/08 10:21:11)
	Mods_2008_CM_5404  // ("ACCESS")
	Mods_2011_06  // CJ Miller`06/27/11, 16:26:19      ` If [PRJ_ProjectDetails] locked set to non-enterable
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		ut_SetStringOrTextFilter(->[PRJ_ReportData:118]RPT_Comments_txt:6)
		OBJECT SET ENTERABLE:C238(*; "RPT@"; True:C214)
		OBJECT SET ENABLED:C1123(bValidate; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(bDelete; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(Button1; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
		C_LONGINT:C283($Color_l)
		$Color_l:=<>PRJ_Color_editable
		
		If (Record number:C243([PRJ_ReportData:118])=New record:K29:1)
			If (PRJ_ReturnAccessAllowed)
				[PRJ_ReportData:118]PRJ_ProjectID_l:1:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
				[PRJ_ReportData:118]RPT_Received_d:3:=Current date:C33(*)
				OBJECT SET ENABLED:C1123(bValidate; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(bDelete; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(Button1; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			Else 
				CANCEL:C270
			End if 
		Else 
			If (PRJ_ReturnAccessAllowed)
				OBJECT SET ENABLED:C1123(bValidate; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(bDelete; True:C214)  // Command Replaced was o_ENABLE BUTTON 
				OBJECT SET ENABLED:C1123(Button1; True:C214)  // Command Replaced was o_ENABLE BUTTON 
			Else 
				OBJECT SET ENTERABLE:C238(*; "RPT@"; False:C215)
				
				$Color_l:=<>PRJ_Color_Not_editable
			End if 
		End if 
		OBJECT SET RGB COLORS:C628(*; "RPT@"; Col_paletteToRGB(Abs:C99($Color_l)%256); Col_paletteToRGB(Abs:C99($Color_l)\256))  // **Replaced o OBJECT SET COLOR(*; "RPT@"; $Color_l)
	: (Form event code:C388=On Validate:K2:3)
		PRJ_SetProjectChangesMade(->[PRJ_ReportData:118]; ->[PRJ_ReportData:118]RPT_ModifiedBy_s:8; ->[PRJ_ReportData:118]RPT_ModifiedTimeStamp_s:9)
End case 

//End Form Method: ReportData.i