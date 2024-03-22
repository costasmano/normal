//%attributes = {"invisible":true}
//Method: Compiler_SFA
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/31/17, 13:52:22
	// ----------------------------------------------------
	//Created : 
	Mods_2017_05
	Mods_2018_01  //Fix Compiler issues
	//Modified by: Chuck Miller (1/9/18 13:06:22)
	
End if 
//
C_OBJECT:C1216(<>SCRRPT_SavedData_o)

If (False:C215)
	C_TEXT:C284(SFA_getServerFileList; $1)
	C_POINTER:C301(SFA_getServerFileList; $2)
	C_LONGINT:C283(SFA_getServerFileList; $3)
	
	C_TEXT:C284(SFA_GetBridgeFolder; $1)
	C_TEXT:C284(SFA_GetBridgeFolder; $2)
	C_POINTER:C301(SFA_GetBridgeFolder; $3)
	C_TEXT:C284(SFA_GetBridgeFolder; $4)
	C_TEXT:C284(SFA_GetBridgeFolder; $5)
	
	C_TEXT:C284(SFA_openRatingReport; $1)
	
	C_TEXT:C284(SFA_OpenScannedReport; $1)
	C_TEXT:C284(SFA_OpenScannedReport; $2)
	
	C_TEXT:C284(SFA_GetAvailRatingRpts; $1)
	C_TEXT:C284(SFA_GetAvailRatingRpts; $2)
	
	C_BOOLEAN:C305(SFA_SharedServerAvail; $0)
	C_TEXT:C284(SFA_SharedServerAvail; $1)
	
	C_TEXT:C284(SFA_VerifyMountPoint; $0)
	C_TEXT:C284(SFA_VerifyMountPoint; $1)
	
End if 

//End Compiler_SFA