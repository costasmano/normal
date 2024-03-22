//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/15/09, 11:32:05
	// ----------------------------------------------------
	// Method: DCM_WO_GetText_blob
	// Description
	// 
	// 
	// Parameters
	//$1 : $Type_txt
	// ----------------------------------------------------
	
	Mods_2010_05
End if 
C_TEXT:C284($1)
C_BLOB:C604($0)
C_BLOB:C604(DCM_WO_SpecInst_x; DCM_WO_Traffic_x; DCM_WO_Sched_x; DCM_WO_Scope_x; DCM_WO_Deficiency_x; DCM_WO_Equipment_x)
//TRACE
Case of 
	: ($1="Deficiency")
		$0:=DCM_WO_Deficiency_x
	: ($1="Scope")
		$0:=DCM_WO_Scope_x
	: ($1="Traffic")
		$0:=DCM_WO_Traffic_x
	: ($1="Equipment")
		$0:=DCM_WO_Equipment_x
	: ($1="Schedule")
		$0:=DCM_WO_Sched_x
	: ($1="SpecialInstr")
		$0:=DCM_WO_SpecInst_x
		
End case 
