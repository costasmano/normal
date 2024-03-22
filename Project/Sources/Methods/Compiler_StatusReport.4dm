//%attributes = {"invisible":true}
//Method: Compiler_StatusReport
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 10/29/19, 14:50:14
	// ----------------------------------------------------
	//Created : 
	Mods_2019_10
End if 


C_TEXT:C284(DistrictMethod_txt)
C_LONGINT:C283(DistrictMethoddCode_L)

If (False:C215)
	C_TEXT:C284(STATREP_DistrictMethod; $0)
	C_LONGINT:C283(STATREP_DistrictMethod; $1)
	C_TEXT:C284(STATREP_BridgesSelected; $0)
	C_LONGINT:C283(STATREP_BridgesSelected; $1)
	C_TEXT:C284(STATREP_DefaultPrintForm; $0)
	C_TEXT:C284(STATREP_DefaultPrintForm; $1)
	C_DATE:C307(STATREP_DefaultPrintForm; $2)
	C_TEXT:C284(STATREP_ReportType; $0)
	C_POINTER:C301(STATREP_GetFieldPTR; $0)
	C_TEXT:C284(STATREP_GetFieldPTR; $1)
	C_LONGINT:C283(STATREP_DistrNo; $0)
	C_TEXT:C284(STATREP_DistrNo; $1)
	C_TEXT:C284(STATREP_DistrNo; $2)
End if 

//End Compiler_StatusReport