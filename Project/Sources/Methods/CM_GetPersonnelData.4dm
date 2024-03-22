//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/01/07, 08:57:25
	// ----------------------------------------------------
	// Method: CM_GetPersonnelData
	// Description
	// Get the personnel data for contract management letters
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(6/27/07 16:55:31)
	Mods_2007_CM12_5301
	// Modified by: Costas Manousakis-(Designer)-(4/24/12 16:31:18)
	Mods_2012_04
	//  `Changed to use [Contract_Maintenance]BridgePrjMgr, utf_GetUserPID and PERS_GetInfo to fill the information
End if 
C_TEXT:C284(vWriterInitial)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(CM_MgrName_txt; CM_MgrPhone_txt; CM_MgrInitial_txt; CM_MgrPhoneExt_txt)
vWriterInitial:=Lowercase:C14(F_GetUserInitial(Current user:C182))
READ ONLY:C145([Personnel:42])
CM_MgrName_txt:="Hemendra Bhatt"
CM_MgrPhone_txt:="(617) 973-7572"
CM_MgrPhoneExt_txt:="7572"
CM_MgrInitial_txt:="HRB"
QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8=16)  //Contract mgr
If (Records in selection:C76([Personnel:42])>0)
	FIRST RECORD:C50([Personnel:42])
	CM_MgrPhone_txt:=[Personnel:42]Phone_s:13
	CM_MgrPhoneExt_txt:=Substring:C12(CM_MgrPhone_txt; (Length:C16(CM_MgrPhone_txt)-3))
	
	If ([Personnel:42]Middle Name:4="")
		CM_MgrName_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Last Name:5
		CM_MgrInitial_txt:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	Else 
		CM_MgrName_txt:=[Personnel:42]First Name:3+" "+[Personnel:42]Middle Name:4+" "+[Personnel:42]Last Name:5
		CM_MgrInitial_txt:=Substring:C12([Personnel:42]First Name:3; 1; 1)+Substring:C12([Personnel:42]Middle Name:4; 1; 1)+Substring:C12([Personnel:42]Last Name:5; 1; 1)
	End if 
	CM_MgrInitial_txt:=Uppercase:C13(CM_MgrInitial_txt)
End if 
C_LONGINT:C283($Index_L)
$Index_L:=utf_GetUserPID([Contract_Maintenance:97]BridgePrjMgr:33)
If ($Index_L>0)
	PERS_GetInfo($Index_L; "FULLNAME"; ->CM_MgrName_txt; "PHONE"; ->CM_MgrPhone_txt; "INITIAL"; ->CM_MgrInitial_txt)
	
	If (CM_MgrPhone_txt#"")
		CM_MgrPhoneExt_txt:=Substring:C12(CM_MgrPhone_txt; Length:C16(CM_MgrPhone_txt)-3)
	Else 
		CM_MgrPhoneExt_txt:=""
	End if 
	
	
End if 

READ WRITE:C146([Personnel:42])