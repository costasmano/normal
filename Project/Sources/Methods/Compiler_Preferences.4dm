//%attributes = {"invisible":true}
//Method: Compiler_Preferences
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/02/15, 12:44:04
	// ----------------------------------------------------
	//Created : 
	Mods_2015_09
	// Modified by: Costas Manousakis-(Designer)-(11/30/15 11:28:11)
	Mods_2015_11
	//  `added new vars and arrays
	// Modified by: Costas Manousakis-(Designer)-(10/7/16 16:51:31)
	Mods_2016_10
	//  `added ◊pref_New4DWR
	// Modified by: Costas Manousakis-(Designer)-(10/25/16 12:23:00)
	Mods_2016_10
	//  `added CBUseOriginalWR
End if 
//

C_BOOLEAN:C305(<>pref_TruckPost_NOL)
C_TEXT:C284(<>ZONEINFO)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(<>VERSION)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(<>TXUSERNAME)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283(<>TRANSFER)
C_TEXT:C284(<>SPREFNAME)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(<>SOURCE)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305(<>SHOWPRINT)
C_LONGINT:C283(<>PROTOCOL)
C_TEXT:C284(<>PREF_SMTP)
C_BOOLEAN:C305(<>MANUALCON)
C_BOOLEAN:C305(<>LOCKUSERTX)
C_TEXT:C284(<>FORWARD)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(<>FORWARDIP)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(<>DESTIP)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305(<>ALLOWTXRX)
C_TEXT:C284(<>DESTINATION)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(<>EmailMethod)
C_TEXT:C284(<>pref_Root_txt)
C_BOOLEAN:C305(<>pref_New4DWR)
C_BOOLEAN:C305(<>pref_StartDbgLog)
C_LONGINT:C283(<>pref_DbgLogValue)

C_LONGINT:C283(<>LSTACKSIZE)

C_LONGINT:C283(CBHideLabel)
C_LONGINT:C283(BAPPLYANDSAVE)
C_TEXT:C284(USER_SMTP_SERVER_TXT)
C_LONGINT:C283(BREVERTTOSAVED)
C_LONGINT:C283(CBSHOWPRINT)
C_LONGINT:C283(CBUseOriginalWR)

If (False:C215)
	
	ARRAY TEXT:C222(<>PrefNames_atxt; 0)
	ARRAY POINTER:C280(<>PrefVariables_aptr; 0)
	
	//UT_CONTROLUSERPREFS
	C_TEXT:C284(ut_ControlUserPrefs; $1)
	
End if 

//End Compiler_Preferences