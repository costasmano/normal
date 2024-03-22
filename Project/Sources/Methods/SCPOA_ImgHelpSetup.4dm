//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/12/09, 09:40:53
	// ----------------------------------------------------
	// Method: SCPOA_ImgHelpSetup
	// Description
	// Setup the help variables for the generic help menus
	// 
	// Parameters
	// $1 : $Action ("INIT" | "RESET")
	// ----------------------------------------------------
	
	Mods_2009_05
End if 
C_TEXT:C284($1; $Action)
$Action:=$1
Case of 
	: ($Action="INIT")
		C_TEXT:C284(SCPOA_IMG1stRechlp_0)
		C_TEXT:C284(vGEN_FirstRec_txt; vGEN_DeleteRec_txt)
		C_TEXT:C284(SCPOA_IMGDelRechlp_0; SCPOA_IMGCancRechlp_0; SCPOA_IMGAcceptRechlp_0)
		SCPOA_IMG1stRechlp_0:=vGEN_FirstRec_txt
		SCPOA_IMGDelRechlp_0:=vGEN_DeleteRec_txt
		vGEN_FirstRec_txt:="Image"
		vGEN_DeleteRec_txt:="Current Image"
		
	: ($Action="RESET")
		vGEN_FirstRec_txt:=SCPOA_IMG1stRechlp_0
		vGEN_DeleteRec_txt:=SCPOA_IMGDelRechlp_0
		SCPOA_IMG1stRechlp_0:=""
		SCPOA_IMGDelRechlp_0:=""
		
End case 
