//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/04/08, 12:22:00
	// ----------------------------------------------------
	// Method: SIA_ReleaseBridgeRec
	// Description
	// Release the current Bridge record.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM_5401
End if 
C_BOOLEAN:C305($BridgeTableRO_b)
$BridgeTableRO_b:=Read only state:C362([Bridge MHD NBIS:1])
If (Not:C34($BridgeTableRO_b))
	READ ONLY:C145([Bridge MHD NBIS:1])
End if 
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
UNLOAD RECORD:C212([Bridge MHD NBIS:1])
LOAD RECORD:C52([Bridge MHD NBIS:1])
//SET AUTOMATIC RELATIONS(True;True)
If (Not:C34($BridgeTableRO_b))
	READ WRITE:C146([Bridge MHD NBIS:1])
End if 