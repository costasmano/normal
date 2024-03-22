//Object method bzAccept form [inspections]Critical Member Form
//Accept Button
If (False:C215)
	Mods_2009_03  //CJM 2004 upgrade   `03/27/09, 14:00:59
	// Modified by: Costas Manousakis-(Designer)-(10/17/17 14:25:36)
	Mods_2017_10_bug
	//  `enable debug log recording depending on preference
	// Modified by: Costas Manousakis-(Designer)-(11/8/17 11:57:11)
	Mods_2017_11_bug
	//  `added On Load and on Unload events to the object 
	// Modified by: Costas Manousakis-(Designer)-(6/23/21 12:20:29)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-12-23T00:00:00 13:44:34)
	Mods_2021_12_bug
	//  `call INSP_SaveInspCommts
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If ((<>pref_StartDbgLog) & (<>pref_DbgLogValue>0))
			SET DATABASE PARAMETER:C642(Debug log recording:K37:34; <>pref_DbgLogValue)
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		If (<>pref_StartDbgLog)
			SET DATABASE PARAMETER:C642(Debug log recording:K37:34; 0)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		//INSP_Check4DWriteChgs 
		INSP_SaveInspCommts
		G_Insp_SaveInspection
End case 