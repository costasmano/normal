//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/12/09, 10:01:14
	// ----------------------------------------------------
	// Method: SCPOA_INPInputHelpSetup
	// Description
	//   ` Setup the help variables for the generic help menus
	// 
	// Parameters
	// $1 : $Action ("INIT" | "RESET")
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(12/16/09 10:13:08)
	Mods_2009_12
	//Added the help for the Accept button
End if 
C_TEXT:C284($1; $Action)
$Action:=$1
Case of 
	: ($Action="INIT")
		C_TEXT:C284(SCPOA_INP1stRechlp_0)
		C_TEXT:C284(SCPOA_INPDelRechlp_0; SCPOA_INPCloseRechlp_0; SCPOA_INPAcceptRechlp_0)
		C_TEXT:C284(vGEN_FirstRec_txt; vGEN_DeleteRec_txt; vGEN_Close_txt; vGEN_DeleteRec_txt; vGEN_Accept_txt)
		SCPOA_INP1stRechlp_0:=vGEN_FirstRec_txt
		SCPOA_INPDelRechlp_0:=vGEN_DeleteRec_txt
		SCPOA_INPCloseRechlp_0:=vGEN_Close_txt
		SCPOA_INPAcceptRechlp_0:=vGEN_Accept_txt
		vGEN_FirstRec_txt:="Image"
		vGEN_DeleteRec_txt:="Current Bridge Scour POA"
		vGEN_Close_txt:=vGEN_DeleteRec_txt
		vGEN_Accept_txt:=vGEN_DeleteRec_txt
		
	: ($Action="RESET")
		vGEN_FirstRec_txt:=SCPOA_INP1stRechlp_0
		vGEN_DeleteRec_txt:=SCPOA_INPDelRechlp_0
		vGEN_Close_txt:=SCPOA_INPCloseRechlp_0
		vGEN_Accept_txt:=SCPOA_INPAcceptRechlp_0
		SCPOA_INP1stRechlp_0:=""
		SCPOA_INPDelRechlp_0:=""
		SCPOA_INPCloseRechlp_0:=""
		SCPOA_INPAcceptRechlp_0:=""
		
End case 
